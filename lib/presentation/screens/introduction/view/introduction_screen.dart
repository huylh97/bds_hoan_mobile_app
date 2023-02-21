import 'package:bds_hoan_mobile/configs/app_colors.dart';
import 'package:bds_hoan_mobile/configs/app_constants.dart';
import 'package:bds_hoan_mobile/configs/routes.dart';
import 'package:bds_hoan_mobile/presentation/screens/introduction/view/widgets/care_view.dart';
import 'package:bds_hoan_mobile/presentation/screens/introduction/view/widgets/center_next_button.dart';
import 'package:bds_hoan_mobile/presentation/screens/introduction/view/widgets/mood_diary_vew.dart';
import 'package:bds_hoan_mobile/presentation/screens/introduction/view/widgets/relax_view.dart';
import 'package:bds_hoan_mobile/presentation/screens/introduction/view/widgets/top_back_skip_view.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/_utils.dart';
import 'package:flutter/material.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController?.animateTo(0.2);
    super.initState();
    UtilPreferences.setBool(AppConstant.showedIntro, true);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController?.value);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: ClipRect(
        child: Stack(
          children: [
            RelaxView(
              animationController: _animationController!,
            ),
            CareView(
              animationController: _animationController!,
            ),
            MoodDiaryVew(
              animationController: _animationController!,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController!,
            ),
            CenterNextButton(
              animationController: _animationController!,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.6, duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 && _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.2 && _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController!.value > 0.4 && _animationController!.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.6 && _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.8 && _animationController!.value <= 1.0) {
      _animationController?.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 && _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController!.value > 0.2 && _animationController!.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController!.value > 0.4 && _animationController!.value <= 0.6) {
      _toHomeScreen();
    }
  }

  void _toHomeScreen() {
    Navigator.pushReplacementNamed(context, Routes.subcription);
  }
}
