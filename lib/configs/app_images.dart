class AppImages {
  static const String defaultThumb = "https://bds_hoan_mobile.com/static/media/logo_192.0801aa8d.png";
  static const String createNewGroup = "assets/images/create_new_group.png";

  ///Singleton factory
  static final AppImages _instance = AppImages._internal();

  factory AppImages() {
    return _instance;
  }

  AppImages._internal();
}
