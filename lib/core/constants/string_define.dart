
class AppString{
  static final AppString _singleton = AppString._internal();
  factory AppString() {
    return _singleton;
  }
  AppString._internal();

  static const String kIosAppVersion = "1";

  
  static const String kInternetCheck = 'Please check network connection and try again!';
  static String kAllow = "Allow";
  static String kPermission = "Permission";
  static String kLocation = "Location";
  static String kCamera = "Camera";
  static String kMicrophone = "Microphone";
  static String kSMS = "SMS";
  static String kOk = "Ok";
  static String kPhotosAndMedia = "Photos & Media";
  static String kTitle = "Allow app permissions";
  static String kDoNotAllow = "Don't Allow";
  static String kSubTitle = "Allow permission for personalised experience";
  static String kAllMandateTitle = "Your Data is safe. All permissions are mandatory.";

  static String kCameraPermissionSubtitle = "We need camera access for the app's functionality, which enables you to capture profile image";
  static String kLocationPermissionSubtitle = "We need your location permission to help you discover nearby animals, log or upload new animal sightings, and display them on the map based on their upload location. Rest assured, your location data is used only for these purposes and is securely processed in compliance with privacy standards.";
  static String kMicroPhonePermissionSubtitle = "We need microphone access for using camera functionality.";
  static String kPhotosAndMedianPermissionSubtitle = "We need gallery access for the app's functionality, which enables you to upload your profile picture";

  /// Images
  static const String logo = "assets/png/logo.png";
  static const String bgImage1 = "assets/png/bg_image1.png";
  static const String bgImage2 = "assets/png/bg_image2.png";
  static const String splashLogo = "assets/png/splash_logo.png";
  static const String welcomeBgImage = "assets/png/welcome_bg_image.png";
  static const String groupDemoImage = "assets/png/group_demo.png";
  static const String mapDemo = "assets/png/map_demo.png";
  static const String findDriveMates = "assets/png/find_drive_mates.png";
  static const String userDemo = "assets/png/user_demo.png";

  /// Svg
  static const String arrowBack = "assets/svg/arrow_back.svg";
  static const String user = "assets/svg/User.svg";
  static const String chatSvg = "assets/svg/chat.svg";
  static const String carSvg = "assets/svg/car.svg";
  static const String profileSvg = "assets/svg/profile.svg";
  static const String usersSvg = "assets/svg/users.svg";
  static const String speakerMute = "assets/svg/speaker_mute.svg";
  static const String mic = "assets/svg/mic.svg";
  static const String clear = "assets/svg/clear.svg";
  static const String speaker = "assets/svg/speaker.svg";
  static const String moreVert = "assets/svg/more_vert.svg";
  static const String call = "assets/svg/call.svg";
  static const String block = "assets/svg/block.svg";
  static const String location = "assets/svg/location.svg";
  static const String startLocationSvg = "assets/svg/start_location.svg";
  static const String destinationLocationSvg = "assets/svg/destination_location.svg";
  static const String dottedLineSvg = "assets/svg/dotted_line.svg";
  static const String calendar = "assets/svg/calendar.svg";
  static const String manMoveSvg = "assets/svg/man_move.svg";
  static const String thumbsDown = "assets/svg/thumbs_down.svg";
  static const String thumbsUp = "assets/svg/thumbs_up.svg";
  static const String edit = "assets/svg/edit.svg";
  static const String settings = "assets/svg/settings.svg";
  static const String warning = "assets/svg/warning.svg";

}