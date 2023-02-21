import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/presentation/app_container/widgets/app_drawer.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_pending/cubit/subcription_pending_cubit.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_common.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_string.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_validate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcriptionPendingView extends StatefulWidget {
  SubcriptionPendingView({Key? key, required this.isSubcription}) : super(key: key);

  bool isSubcription;

  @override
  State<SubcriptionPendingView> createState() => _SubcriptionPendingViewState();
}

class _SubcriptionPendingViewState extends State<SubcriptionPendingView> {
  late final SubcriptionPendingCubit cubit;

  final kTextStyle = const TextStyle(
    fontSize: 23,
    color: Colors.black,
    fontWeight: FontWeight.w700,
  );

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SubcriptionPendingCubit>(context);
    // cubit.getSubscriptionInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBgColor,
        drawer: const AppDrawer(),
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDimension.kScaffoldHorPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 40), child: DefaultDivider()),
                const SizedBox(height: 30),
                BlocBuilder<SubcriptionPendingCubit, SubcriptionPendingState>(
                  builder: (context, state) {
                    if (widget.isSubcription) {
                      return subcripitionConfirmPending(state);
                    }
                    return notBelongtoAnyGroup(state);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget subcripitionConfirmPending(SubcriptionPendingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          Text('Thanh toán đang trong quá trình xác minh.', style: kTextStyle),
          Row(
            children: [
              Text('Vui lòng đợi hoặc gọi ', style: kTextStyle),
              Text('0932123123', style: kTextStyle.copyWith(decoration: TextDecoration.underline))
            ],
          ),
          const SizedBox(height: 25),
          Image.asset(AppImages.createNewGroup, width: 260)
        ]),
      ],
    );
  }

  Widget notBelongtoAnyGroup(SubcriptionPendingState state) {
    return Column(
      children: [
        Text(
          'Bạn chưa là thành viên của bất kỳ nhóm nào.',
          style: kTextStyle,
        ),
        RichText(
          text: TextSpan(
            text: 'Hãy liên hệ với ',
            style: kTextStyle,
            children: <TextSpan>[
              TextSpan(text: 'Admin', style: kTextStyle.copyWith(color: AppColors.primary)),
              const TextSpan(text: ' để được thêm vào nhóm.'),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Image.asset(AppImages.createNewGroup, width: 260)
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      title: Text(
        'Đăng ký đại lý',
        style: AppBloc.applicationCubit.appTextStyle.mediumBold,
      ),
    );
  }
}
