// ignore_for_file: constant_identifier_names

class ApiUrl {
  static final ApiUrl _singleton = ApiUrl._internal();
  factory ApiUrl() {
    return _singleton;
  }
  ApiUrl._internal();

  /// Base Live
  static const kDomain = "https://v5.checkprojectstatus.com/drivemate/";
  static const kBaseUrlDomain = "api/v1/";

  static const BASE_URL = kDomain + kBaseUrlDomain;

  // static const String SIGNUP_API_URL                   = "${BASE_URL}signup";
  // static const String LOGIN_API_URL                    = "${BASE_URL}log_in";
  // static const String SIGN_VERIFY_OTP_API_URL          = "${BASE_URL}signverifyotp";
  // static const String VERIFY_OTP_API_URL               = "${BASE_URL}verify_otp";
  // static const String FORGOT_PASSWORD_API_URL          = "${BASE_URL}forgot_password";
  // static const String RESET_PASSWORD_API_URL           = "${BASE_URL}reset_password";
  // static const String RESEND_OTP_API_URL               = "${BASE_URL}resendotp";
  // static const String UPDATE_PROFILE_API_URL           = "${BASE_URL}update_profile";
  // static const String USER_PROFILE_API_URL             = "${BASE_URL}user_profile";
  // static const String LOGOUT_API_URL                   = "${BASE_URL}logout";
  // static const String CREATE_DRIVE_API_URL             = "${BASE_URL}createDrive";
  // static const String myDrivesApiUrl                   = "${BASE_URL}myDrive";
  // static const String startDriveApiUrl                 = "${BASE_URL}startDrive";
  // static const String blockedUserApiUr                 = "${BASE_URL}blockedUsers";
  // static const String blockUserApiUrl                  = "${BASE_URL}userBlock";
  // static const String unblockedUserApiUr               = "${BASE_URL}userunBlock";
  // static const String changePasswordApiUrl             = "${BASE_URL}change_password";
  // static const String notificationOnOffApiUrl          = "${BASE_URL}notificationOnOff";
  // static const String deleteAccountApiUrl              = "${BASE_URL}deleteaccount";
  // static const String privacyPolicyApiUrl              = "${BASE_URL}privacypolicy";
  // static const String termsConditionApiUrl             = "${BASE_URL}termscondition";


  // static const SOCKET_URL                        = "https://v4.checkprojectstatus.com:1100/";
  // static const GOOGLE_ROUTE_API_URL              = "https://routes.googleapis.com/directions/v2:computeRoutes";
  // static const ABOUT_US_API_URL                  = "http://65.1.218.108:4400/api/common/page/about-us";
  static const TERMS_AND_CONDITIONS_URL          = "${kDomain}terms-and-conditions";
  static const PRIVACY_POLICY_URL                = "${kDomain}privacy-policy";
  
}