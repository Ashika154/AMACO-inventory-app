import 'package:amaco_app/config/app_dimensions.dart';
import 'package:amaco_app/core/custom_widgets/app_decorations.dart';
import 'package:amaco_app/core/custom_widgets/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import 'custom_text.dart';

class DropdownWithSearch extends StatefulWidget {
  final List<String> items;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final String? errorText;
  final String searchHint;
  final String? initialValue;
  final void Function(String?)? onChanged;
  final bool isShowSearch;
  final bool isShowPrefix;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final String? suffixText;
  final Color? backgroundColor;

  const DropdownWithSearch(
      {Key? key,
      required this.items,
      this.onChanged,
      this.hintText = "Select an item",
      this.errorText,
      this.searchHint = "Search...",
      this.initialValue,
      this.prefixIcon,
      this.suffixIcon,
      this.isShowSearch = false,
      this.isShowPrefix = false,
      this.width,
      this.height,
      this.borderRadius,
      this.suffixText,
      this.backgroundColor})
      : super(key: key);

  @override
  _DropdownWithSearchState createState() => _DropdownWithSearchState();
}

class _DropdownWithSearchState extends State<DropdownWithSearch> {
  List<String> _filteredItems = [];
  String? _selectedValue;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(widget.items);
    _selectedValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant DropdownWithSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      setState(() {
        _selectedValue = widget.initialValue;
      });
    }
    if (oldWidget.items != widget.items) {
      _filterItems(_searchController.text);
      if (_selectedValue != null && !widget.items.contains(_selectedValue)) {
        _selectedValue = null;
        widget.onChanged?.call(null);
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    if (query.isEmpty) {
      _filteredItems = widget.items;
    } else {
      _filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void _showDropdownMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    _searchController.clear();
    _filterItems('');

    showMenu<String>(
      context: context,
      color: AppColors.primaryWhite,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width,
        0,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter menuSetState) {
              return Container(
                width: size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.isShowSearch)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: SizedBox(
                          width: size.width,
                          child: FormTextField(
                            controller: _searchController,
                            hintText: widget.searchHint,
                            autoFocus: true,
                            onChanged: (value) {
                              _filterItems(value);
                              menuSetState(() {});
                            },
                          ),
                        ),
                      ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * .5,
                          maxWidth: MediaQuery.of(context).size.width * .5),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          return ListTile(
                            // selected: item == _selectedValue,
                            title: CustomText(text: item),
                            onTap: () {
                              setState(() {
                                _selectedValue = item;
                              });
                              Future.microtask(() {
                                if (widget.onChanged != null) {
                                  widget.onChanged!(item);
                                }
                              });
                              Navigator.pop(context, item);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
      elevation: 8.0, // Standard elevation for menus
    ).then((selectedValueFromMenu) {
      if (mounted &&
          selectedValueFromMenu == null &&
          _selectedValue == null &&
          widget.initialValue != null) {
        setState(() {
          _selectedValue = widget.initialValue;
        });
      }

      // Optional: Reset search state after closing (already done when opening)
      // _searchController.clear();
      // _filterItems('');
      // if (mounted) {
      //   setState(() {}); // Update main widget display if filter reset affects it
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showDropdownMenu(context),
          child: Container(
            height: 50,
            width: 340,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                border: Border.all(
                  color: AppColors.secondaryColor,
                ),
                borderRadius: BorderRadius.circular(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.isShowPrefix == true) ...[
                  widget.prefixIcon ??
                      Icon(
                        Icons.search,
                        color: AppColors.grey6B6B6B,
                        size: 18, // Slightly larger?
                      ),
                  4.width, // Use your extension
                ],
                Expanded(
                  child: CustomText(
                    text: _selectedValue ?? widget.hintText,
                    fontSize: AppFontSize.s12,
                    color: _selectedValue != null
                        ? AppColors.black000000
                        : AppColors.greyText,
                    fontWeight: AppFontWeight.w400,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.suffixText != null) ...[
                  4.width,
                  CustomText(
                    text: widget.suffixText,
                    fontSize: AppFontSize.s12,
                    fontWeight: AppFontWeight.w500,
                    color: AppColors.grey6B6B6B,
                  ),
                  4.width,
                ],
                widget.suffixIcon ??
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: AppColors.grey6B6B6B,
                      size: 20,
                    ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 8.0),
            child: CustomText(
              text: widget.errorText!,
              color: Colors.red,
              fontSize: AppFontSize.s12,
            ),
          ),
      ],
    );
  }
}

class DropdownMultiSelectWithSearch extends StatefulWidget {
  final List<String> items;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String hintText;
  final String? errorText;
  final String searchHint;
  final List<String>? initialValues;
  final void Function(List<String>)? onChanged;
  final bool isShowSearch;
  final bool isShowPrefix;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final String? suffixText;
  final Color? backgroundColor;
  final int? maxSelectedItems;
  final String selectedItemsTextSeparator;
  final Color? selectedTextColor;
  final String? Function(List<String>)? validator;

  const DropdownMultiSelectWithSearch({
    Key? key,
    required this.items,
    this.onChanged,
    this.hintText = "Select items",
    this.errorText,
    this.searchHint = "Search...",
    this.initialValues,
    this.prefixIcon,
    this.suffixIcon,
    this.isShowSearch = false,
    this.isShowPrefix = false,
    this.width,
    this.height,
    this.borderRadius,
    this.suffixText,
    this.backgroundColor,
    this.maxSelectedItems,
    this.selectedItemsTextSeparator = ", ",
    this.selectedTextColor,
    this.validator,
  }) : super(key: key);

  @override
  _DropdownMultiSelectWithSearchState createState() =>
      _DropdownMultiSelectWithSearchState();
}

class _DropdownMultiSelectWithSearchState
    extends State<DropdownMultiSelectWithSearch> {
  List<String> _filteredItems = [];
  List<String> _selectedValues = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(widget.items);
    _selectedValues = List.from(widget.initialValues ?? []);
  }

  @override
  void didUpdateWidget(covariant DropdownMultiSelectWithSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValues != widget.initialValues) {
      setState(() {
        _selectedValues = List.from(widget.initialValues ?? []);
      });
    }
    if (oldWidget.items != widget.items) {
      _filterItems(_searchController.text);
      // Remove any selected values that are no longer in the items list
      _selectedValues.removeWhere((value) => !widget.items.contains(value));
      if (_selectedValues.isNotEmpty) {
        widget.onChanged?.call(_selectedValues);
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    if (query.isEmpty) {
      _filteredItems = widget.items;
    } else {
      _filteredItems = widget.items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void _toggleItemSelection(String item) {
    setState(() {
      if (_selectedValues.contains(item)) {
        _selectedValues.remove(item);
      } else {
        if (widget.maxSelectedItems != null &&
            _selectedValues.length >= widget.maxSelectedItems!) {
          // Don't add if we've reached max selection
          return;
        }
        _selectedValues.add(item);
      }
    });

    // Notify parent of the change
    widget.onChanged?.call(_selectedValues);
  }

  String _getDisplayText() {
    if (_selectedValues.isEmpty) {
      return widget.hintText;
    }

    if (_selectedValues.length == 1) {
      return _selectedValues.first;
    }

    if (widget.maxSelectedItems != null &&
        _selectedValues.length > widget.maxSelectedItems!) {
      return '${_selectedValues.length} selected';
    }

    return _selectedValues.take(3).join(widget.selectedItemsTextSeparator) +
        (_selectedValues.length > 3 ? '...' : '');
  }

  void _showDropdownMenu(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    _searchController.clear();
    _filterItems('');

    showMenu<String>(
      context: context,
      color: AppColors.primaryWhite,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + renderBox.size.height,
        offset.dx + renderBox.size.width,
        0,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter menuSetState) {
              return Container(
                width: size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.isShowSearch)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        child: SizedBox(
                          width: size.width,
                          child: FormTextField(
                            controller: _searchController,
                            hintText: widget.searchHint,
                            autoFocus: true,
                            onChanged: (value) {
                              _filterItems(value);
                              menuSetState(() {});
                            },
                          ),
                        ),
                      ),
                    if (widget.maxSelectedItems != null &&
                        _selectedValues.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: CustomText(
                          text:
                              '${_selectedValues.length}/${widget.maxSelectedItems} selected',
                          fontSize: AppFontSize.s12,
                          color: AppColors.grey6B6B6B,
                        ),
                      ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * .5,
                          maxWidth: MediaQuery.of(context).size.width * .5),
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          return ListTile(
                            leading: Checkbox(
                              value: _selectedValues.contains(item),
                              onChanged: (bool? value) {
                                _toggleItemSelection(item);
                                menuSetState(() {});
                              },
                            ),
                            title: CustomText(
                              text: item,
                              color: _selectedValues.contains(item)
                                  ? widget.selectedTextColor ??
                                      AppColors.black000000
                                  : AppColors.greyText,
                            ),
                            onTap: () {
                              _toggleItemSelection(item);
                              menuSetState(() {});
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showDropdownMenu(context),
          child: Container(
            height: widget.height ?? 40,
            width: widget.width,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? AppColors.primaryWhite,
              border: Border.all(
                color: AppColors.black000000.withAlpha((0.4 * 255).toInt()),
              ),
              borderRadius: widget.borderRadius ?? AppRadius.radius25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.isShowPrefix == true) ...[
                  widget.prefixIcon ??
                      Icon(
                        Icons.search,
                        color: AppColors.grey6B6B6B,
                        size: 18,
                      ),
                  4.width,
                ],
                Expanded(
                  child: CustomText(
                    text: _getDisplayText(),
                    fontSize: AppFontSize.s12,
                    color: _selectedValues.isNotEmpty
                        ? widget.selectedTextColor ?? AppColors.black000000
                        : AppColors.greyText,
                    fontWeight: AppFontWeight.w400,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ),
                if (widget.suffixText != null) ...[
                  4.width,
                  CustomText(
                    text: widget.suffixText,
                    fontSize: AppFontSize.s12,
                    fontWeight: AppFontWeight.w500,
                    color: AppColors.grey6B6B6B,
                  ),
                  4.width,
                ],
                widget.suffixIcon ??
                    Icon(
                      Icons.arrow_drop_down_outlined,
                      color: AppColors.grey6B6B6B,
                      size: 20,
                    ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null && widget.errorText!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 8.0),
            child: CustomText(
              text: widget.errorText!,
              color: Colors.red,
              fontSize: AppFontSize.s12,
            ),
          ),
      ],
    );
  }
}

class DropdownFormField extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final String? initialValue;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool isShowSearch;
  final bool isShowPrefix;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String searchHint;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final String? suffixText;
  final Color? backgroundColor;

  const DropdownFormField({
    Key? key,
    required this.items,
    this.hintText = "Select an item",
    this.initialValue,
    this.onChanged,
    this.validator,
    this.isShowSearch = false,
    this.isShowPrefix = false,
    this.prefixIcon,
    this.suffixIcon,
    this.searchHint = "Search...",
    this.height,
    this.width,
    this.borderRadius,
    this.suffixText,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: initialValue,
      validator: validator,
      builder: (FormFieldState<String> state) {
        return DropdownWithSearch(
          items: items,
          initialValue: state.value,
          hintText: hintText,
          errorText: state.errorText,
          onChanged: (val) {
            state.didChange(val);
            if (onChanged != null) onChanged!(val);
          },
          isShowSearch: isShowSearch,
          isShowPrefix: isShowPrefix,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          searchHint: searchHint,
          height: height,
          width: width,
          borderRadius: borderRadius,
          suffixText: suffixText,
          backgroundColor: backgroundColor,
        );
      },
    );
  }
}
