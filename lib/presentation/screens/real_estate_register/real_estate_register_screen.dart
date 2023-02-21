import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_param.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_register/cubit/real_estate_register_cubit.dart';
import 'package:bds_hoan_mobile/presentation/screens/real_estate_register/real_estate_register_view.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealEstateRegisterScreen extends StatelessWidget {
  const RealEstateRegisterScreen({Key? key, required this.param})
      : super(key: key);

  final RealEstateRegEditParam param;

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as ChangeUserInfoScreenArg;
    return BlocProvider(
      create: (_) => RealEstateRegisterCubit(),
      child: RealEstateRegisterView(param: param),
    );
  }
}
