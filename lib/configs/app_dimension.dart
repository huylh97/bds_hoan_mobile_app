class AppDimension {
  static const double kSizedBoxHeight = 12;
  static const double kMediumSizedBoxHeight = 16;
  static const double kLargeSizedBoxHeight = 32;

  static const double kSizedBoxWidth = 8;
  static const double kMediumSizedBoxWidth = 16;
  static const double kLargeSizedBoxWidth = 24;

  static const double kTextFormFieldVerPadding = 15.0;
  static const double kTextFormFieldHorPadding = 16.0;
  static const double kTextFormFieldMargin = 20.0;

  static const double kScaffoldHorPadding = 18.0;
  static const double kMediumContentPadding = 23.0;
  static const double kScaffoldBottomPadding = 20.0;

  static const double kButtonHeight = 50;
  static const double kButtonBorderRadius = 12.0;
  static const double kButtonSmallBorderRadius = 3.0;
  static const double kButtonMediumBorderRadius = 8.0;
  static const double kButtonLargeBorderRadius = 12.0;

  static const double kDialogSmallBorderRadius = 3.0;
  static const double kDialogMediumBorderRadius = 5.0;
  static const double kDialogLargeBorderRadius = 10.0;

  static const double tabBarHeight = 60;

  static final AppDimension _instance = AppDimension._internal();

  factory AppDimension() {
    return _instance;
  }

  AppDimension._internal();
}
