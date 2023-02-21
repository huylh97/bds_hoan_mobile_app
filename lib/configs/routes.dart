import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_param.dart';
import 'package:bds_hoan_mobile/presentation/screens/app_feedback/view/app_feedback_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_register/real_estate_register_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_view_info/view/real_estate_view_info_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/screens.dart';
import 'package:bds_hoan_mobile/presentation/screens/search_filter/view/search_filtes_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_payment/view/subcription_payment_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_selection/view/subcription_selection_screen.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_view_info/view/subcription_view_info_screen.dart';
import 'package:flutter/material.dart';

class RouteArgs {
  RouteArgs._();
}

class Routes {
  static const register = '/register';
  static const login = '/login';
  static const forgotPassword = '/forgotPassword';
  static const home = "/home";
  static const changeUserInfo = "/changeUserInfo";
  static const changePassword = "/changePassword";

  // Admin
  static const addMember = "/addMember";
  static const memberDetail = "/memberDetail";

  // Register
  static const realEstateRegister = "/realEstateRegister";
  static const realEstateViewInfo = "/realEstateViewInfo";

  // Search Filter
  static const searchFilters = "/searchFilters";

  // Subcription
  static const subcription = "/subcription";
  static const subcriptionPayment = "/subcriptionPayment";
  static const subcriptionPending = "/subcriptionPending";
  static const subcriptionViewInfo = "/subcriptionViewInfo";

  // feecback
  static const feedBack = "/feedBack";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case register:
        return MaterialPageRoute(
          builder: (context) {
            return const RegisterScreen();
          },
          fullscreenDialog: true,
        );

      case login:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
          fullscreenDialog: true,
        );

      case changeUserInfo:
        return MaterialPageRoute(
          builder: (context) {
            return const ChangeUserInfoScreen();
          },
          settings: settings,
        );

      case changePassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ChangePasswordScreen();
          },
          settings: settings,
        );

      case addMember:
        return MaterialPageRoute(
          builder: (context) {
            return const AddMemberScreen();
          },
        );

      case memberDetail:
        return MaterialPageRoute(
          builder: (context) {
            return const MemberDetailScreen();
          },
          settings: settings,
        );

      case realEstateRegister:
        var param = settings.arguments as RealEstateRegEditParam;
        return MaterialPageRoute(
          builder: (context) {
            return RealEstateRegisterScreen(param: param);
          },
          settings: settings,
        );

      case realEstateViewInfo:
        return MaterialPageRoute(
          builder: (context) {
            return RealEstateViewInfoScreen();
          },
          settings: settings,
        );

      case searchFilters:
        return MaterialPageRoute(
          builder: (context) {
            return const SearchFiltersScreen();
          },
          settings: settings,
        );
      case subcription:
        return MaterialPageRoute(
          builder: (context) {
            return const SubcriptionSelectionScreen();
          },
          settings: settings,
        );
      case subcriptionPayment:
        return MaterialPageRoute(
          builder: (context) {
            return const SubcriptionPaymentScreen();
          },
          settings: settings,
        );
      case subcriptionPending:
        var isSubcription = settings.arguments as bool;
        return MaterialPageRoute(
          builder: (context) {
            return SubcriptionPendingScreen(isSubcription: isSubcription);
          },
          settings: settings,
        );

      case subcriptionViewInfo:
        return MaterialPageRoute(
          builder: (context) {
            return SubcriptionViewInfoScreen();
          },
          settings: settings,
        );

      case feedBack:
        return MaterialPageRoute(
          builder: (context) {
            return AppFeedBackScreen();
          },
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
