import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/models/real_estate/real_estate_register_param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/real_estate_search_cubit.dart';

class AddProductIntro extends StatefulWidget {
  const AddProductIntro({Key? key}) : super(key: key);

  @override
  State<AddProductIntro> createState() => _AddProductIntroState();
}

class _AddProductIntroState extends State<AddProductIntro> {
  late final RealEstateSearchCubit cubit;

  final kTextStyle = const TextStyle(
    fontSize: 23,
    color: AppColors.kTextColor,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<RealEstateSearchCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Text('Chưa có sản phẩm nào', style: kTextStyle),
        Wrap(
          children: [
            Text(
              'Hãy ',
              style: kTextStyle,
            ),
            InkWell(
              highlightColor: Colors.white,
              splashColor: Colors.white,
              onTap: () {
                Navigator.pushNamed(context, Routes.realEstateRegister,
                    arguments: RealEstateRegEditParam(
                        processMode: RealEstateProcessMode.register,
                        inputType: RealEstateInputType.vn2000));
              },
              child: Text(
                'thêm sản phẩm',
                style: kTextStyle.copyWith(
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            Text(
              ' đầu tiên',
              style: kTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.createNewGroup, width: 260),
          ],
        )
      ],
    );
  }
}
