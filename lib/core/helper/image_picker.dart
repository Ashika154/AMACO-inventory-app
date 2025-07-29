import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  /// Internal method to pick an image from the given [source].
  static Future<File?> _pickImage(
      ImageSource source, BuildContext context) async {
    try {
      final XFile? file = await _picker.pickImage(source: source);
      if (file != null) {
        return File(file.path);
      }
    } catch (e, st) {
      debugPrint('Image pick error: $e\n$st');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to pick image. Please try again.'),
          ),
        );
      }
    }
    return null;
  }

  /// Checks and requests [permission], showing rationale if needed.
  static Future<bool> _ensurePermission(
    BuildContext context,
    Permission permission,
    String name,
  ) async {
    try {
      // Check current status
      var status = await permission.status;
      if (status.isGranted) return true;

      // Show rationale if first denied
      if (status.isDenied && await permission.shouldShowRequestRationale) {
        final retry = await _showPermissionDialog(context, name);
        if (retry == _RationaleAction.openSettings) {
          await openAppSettings();
          return (await permission.status).isGranted;
        } else if (retry == _RationaleAction.retry) {
          status = await permission.request();
          return status.isGranted;
        }
        return false;
      }

      // Otherwise just request
      status = await permission.request();
      return status.isGranted;
    } catch (e, st) {
      debugPrint('Permission check error: $e\n$st');
      return false;
    }
  }

  /// Public: pick from gallery (requires storage/photos permission).
  static Future<File?> pickFromGallery(BuildContext context) async {
    final ok = await _ensurePermission(
        context,
        Permission.photos, // on Android < 33, use storage if needed
        'Gallery');
    return ok ? _pickImage(ImageSource.gallery, context) : null;
  }

  /// Public: pick from camera (requires camera permission).
  static Future<File?> pickFromCamera(BuildContext context) async {
    final ok = await _ensurePermission(context, Permission.camera, 'Camera');
    return ok ? _pickImage(ImageSource.camera, context) : null;
  }

  /// Shows a bottom sheet to choose source.
  static Future<File?> showSourceSheet(BuildContext context) async {
    if (!context.mounted) return null;
    return await showModalBottomSheet<File?>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Select Image Source',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOption(
                      context, Icons.photo_library, 'Gallery', pickFromGallery),
                  _buildOption(
                      context, Icons.camera_alt, 'Camera', pickFromCamera),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  /// Helper to build each selection button.
  static Widget _buildOption(
    BuildContext context,
    IconData icon,
    String label,
    Future<File?> Function(BuildContext) onTap,
  ) {
    return GestureDetector(
      onTap: () async {
        final img = await onTap(context);
        if (context.mounted) Navigator.of(context).pop(img);
      },
      child: Column(
        children: [
          Icon(icon, size: 40, color: Theme.of(context).primaryColor),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  /// Presents a dialog explaining why [permissionName] is needed.
  static Future<_RationaleAction> _showPermissionDialog(
      BuildContext context, String permissionName) async {
    final result = await showDialog<_RationaleAction>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('$permissionName Permission'),
        content: Text(
            'This app needs $permissionName access to let you choose images.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(_RationaleAction.cancel),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(_RationaleAction.retry),
            child: const Text('Try Again'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(ctx).pop(_RationaleAction.openSettings),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
    return result ?? _RationaleAction.cancel;
  }
}

/// Internal enum for rationale dialog actions.
enum _RationaleAction { retry, openSettings, cancel }
