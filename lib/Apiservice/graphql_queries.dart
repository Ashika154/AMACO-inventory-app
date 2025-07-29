

const String userRegisterMutation = r'''
   mutation AppUserRegister($input: AppUserRegister!) {
      AppUserRegister(
        input: $input
      ) 
      {
        success
        message
        accessToken
        tokenType
        requiresOtp
        otpEmail
    }
  }
''';

const String userVerificationRegisterMutation = """
   mutation AppUserVerifyregister(\$input: AppUserVerifyregister!) {
      AppUserVerifyregister(
        input: \$input
      ) 
      {
        success
        message
        accessToken
        tokenType
        requiresOtp
        otpEmail
    }
  }
""";

const String loginMutation = """
   mutation AppUserLogin(\$input: AppUserLogin!) {
      AppUserLogin(
        input: \$input
      ) 
      {
        success
        message
        accessToken
        tokenType
        requiresOtp
        otpEmail
    }
  }
""";

const String resendMutation = """
   mutation AppUserResendVerifyCode(\$input: AppUserResendVerifyCode!) {
      AppUserResendVerifyCode(
        input: \$input
      ) 
      {
        success
        message
        accessToken
        tokenType
        requiresOtp
        otpEmail
    }
  }
""";

const String forgotPasswordMutation = """
   mutation AppUserForgotPassword(\$input: AppUserForgotPassword!) {
      AppUserForgotPassword(
        input: \$input
      ) 
      {
        success
        message
        accessToken
        tokenType
        requiresOtp
        otpEmail
    }
  }
""";

const String forgotPasswordEmailVerificationMutation = """
   mutation AppUserVerifyforgotPassword(\$input: AppUserVerifyforgotPassword !) {
      AppUserVerifyforgotPassword(
        input: \$input
      ) 
      {
        success
        message
    }
  }
""";

const String resetPasswordMutation = """
   mutation AppUserResetPassword(\$input: AppUserResetPassword!) {
      AppUserResetPassword(
        input: \$input
      ) 
      {
        success
        message
        accessToken
        tokenType
        requiresOtp
        otpEmail
    }
  }
""";

const String fetchProfileDataQuery = """
query AppUsergetpersonaldata {
    AppUsergetpersonaldata {
        id
        name
        email
        tradeLicense
        password
        status
        createdAt
        updatedAt
        updatedBy
        deletionReasonOption
        deletionReasonDetails
        profileImage
        phoneNumber
        dateOfBirth
        gender
    }
}
  """;

const String fetchCompanyListQuery = """
query Companies {
    companies {
        id
        name
        logo
        offerDescription
        paymentType
        smtpHost
        smtpPort
        smtpUsername
        smtpPassword
        category
        tradeLicense
        field1
        field2
        field3
        createdAt
        updatedAt
        createdBy
        updatedBy
        status
    }
}
""";


const String profileDataUpdateMutation = """
  mutation AppUserUpdatePersonalData(\$input: AppUserUpdatePersonalData!){
    AppUserUpdatePersonalData(
        input: \$input
    ) {
        success
        message
    }
  }""";

const String addAddressMutation = """ 
  mutation AppUserAddaddress (\$input :AppUserAddaddress!) {
    AppUserAddaddress(
        input: \$input
    ) {
        success
        message
    }
  }
""";

const String getUserAddressesQuery =""" 
  query AppUserGetalladdress {
    AppUserGetalladdress {
        id
        userId
        addressType
        address
        state
        city
        country
        pinnumber
        phonenumber
        primaryAddress
        createdAt
    }
  }
""";

const String deleteAddressMutation = """
mutation AppUserDeleteaddress(\$input :AppUserDeleteaddress!) {
    AppUserDeleteaddress(input: \$input) {
        success
        message
    }
}
 """;


const String addCardMutation = """
mutation AppUserAddCard(\$input :AppUserAddCard!) {
    AppUserAddCard(input: \$input) {
        success
        message
    }
}
 """;

const String fetchCardsQuery = """
  query AppUsergetallcards {
    AppUsergetallcards {
        id
        userId
        cardHolderName
        cardNumber
        expiryDate
        cvv
        primaryCard
        createdAt
    }
  }
 """;


const String removeCardMutation = """
mutation AppUserDeleteCard(\$input :AppUserDeleteCard!) {
    AppUserDeleteCard(input: \$input) {
        success
        message
    }
}
 """;

const String changePasswordMutation = """ 
  mutation AppUserChangePassword (\$input :AppUserChangePassword!) {
    AppUserChangePassword(
        input: { input: \$input }
    ) {
        success
        message
    }
  }
""";
const String fetchProductListQuery = """
query Products {
  products {
    id
    name
    companyId
    description
    categoryId
    subCategoryId
    productCost
    productUnit
    deliveryCost
    minimumQuantity
    productDetails
    productAvailability
    productQuantity
    productImage
    status
    createdAt
    updatedAt
    createdBy
    updatedBy
  }
}
""";