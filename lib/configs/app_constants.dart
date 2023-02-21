class AppConstant {
  AppConstant._();

  // Share Preferences
  static String accessToken = 'access_token';
  static String fcmToken = 'fcm_token';
  static String showedIntro = 'showed_intro';

  // Fetch Data
  static const int kDataPerPage = 20;

  // Setup Staging env
  // static const String urlUser = 'http://api-bds-hoan.weit.tech/v1';
  static const String urlUser = 'http://14.225.255.148:7177/v1';

  static const defaltAvatarUrl = 'https://api.imbachat.com/plugins/imbasynergy/imbachat/assets/images/default-avatar.png';
}
