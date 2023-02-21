import 'package:bds_hoan_mobile/bloc_global/app_bloc.dart';
import 'package:bds_hoan_mobile/bloc_global/application/app_text_style.dart';
import 'package:bds_hoan_mobile/bloc_global/bloc.dart';
import 'package:bds_hoan_mobile/configs/_config.dart';
import 'package:bds_hoan_mobile/data/enums/api_call_status.dart';
import 'package:bds_hoan_mobile/data/models/subcription/subcription_info.dart';
import 'package:bds_hoan_mobile/presentation/app_container/widgets/app_drawer.dart';
import 'package:bds_hoan_mobile/presentation/screens/subcription/subcription_selection/cubit/subcription_selection_cubit.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/buttons/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/common/widget.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/text_input/app_text_input.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_common.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_string.dart';
import 'package:bds_hoan_mobile/presentation/shared_widgets/utils/util_validate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubcriptionSelectionView extends StatefulWidget {
  const SubcriptionSelectionView({
    Key? key,
  }) : super(key: key);

  @override
  State<SubcriptionSelectionView> createState() => _SubcriptionSelectionViewState();
}

class _SubcriptionSelectionViewState extends State<SubcriptionSelectionView> {
  late final SubcriptionSelectionCubit cubit;
  final CarouselController _controller = CarouselController();
  int? selectedIndexSubcription;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numMonthEditingController = TextEditingController();
  int curNumMonth = 1;
  int? totalPrice;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<SubcriptionSelectionCubit>(context);
    cubit.getSubscriptionInfo();
    _numMonthEditingController.text = '$curNumMonth';
  }

  void onAddSubtractNumMonth(bool isAdd) {
    if (!isAdd && curNumMonth < 1) {
      return;
    }
    if (isAdd) {
      setState(() {
        int newNumMonth = curNumMonth + 1;
        _numMonthEditingController.text = '$newNumMonth';
        calculateTotalPrice(newNumMonth, selectedIndexSubcription);
        curNumMonth = newNumMonth;
      });
    } else {
      setState(() {
        int newNumMonth = curNumMonth - 1;
        _numMonthEditingController.text = '$newNumMonth';
        calculateTotalPrice(newNumMonth, selectedIndexSubcription);
        curNumMonth = newNumMonth;
      });
    }
  }

  void calculateTotalPrice(int newNumMonth, int? selectedIndexSubcription) {
    setState(() {
      totalPrice = newNumMonth * cubit.state.dataList![selectedIndexSubcription ?? 0].price!;
    });
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
                BlocBuilder<SubcriptionSelectionCubit, SubcriptionSelectionState>(
                  builder: (context, state) {
                    if (state.apiCallStatus == ApiCallStatus.loading) {
                      return Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state.dataList != null) {
                      return subcriptionList(state);
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget subcriptionList(SubcriptionSelectionState state) {
    final List<Widget> subcriptionInfoSliders = state.dataList!
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: 1000,
                          height: 1000,
                          color: (item.id! % 2 == 0) ? Color(0xFFFFBC00) : ((item.id! % 3 == 0) ? Color(0xFFFF0656) : Color(0xFF9C8DEB)),
                        ),
                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(item.name ?? '', style: AppBloc.applicationCubit.appTextStyle.mediumWhite),
                                  Text('Team lên đến ${item.maxMembers} người', style: AppBloc.applicationCubit.appTextStyle.mediumWhiteWeightNormal),
                                  Text(
                                    '${UtilString.toCommaString('${item.price}')} đ/tháng',
                                    style: AppBloc.applicationCubit.appTextStyle.mediumWhite,
                                  )
                                ],
                              )),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();

    if (totalPrice == null) {
      totalPrice = state.dataList![0].price ?? 0 * curNumMonth ?? 0;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bạn muốn đăng ký ', style: AppBloc.applicationCubit.appTextStyle.largeBold),
        Text('đội nhóm?', style: AppBloc.applicationCubit.appTextStyle.largeBold),
        const SizedBox(
          height: AppDimension.kMediumSizedBoxHeight,
        ),
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            // autoPlay: true,
            aspectRatio: 1.5,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                selectedIndexSubcription = index;
                calculateTotalPrice(curNumMonth, index);
              });
            },
          ),
          items: subcriptionInfoSliders,
        ),
        const SizedBox(
          height: AppDimension.kMediumSizedBoxHeight,
        ),
        Form(
            key: _formKey,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              onAddSubtractNumMonth(false);
                            },
                            child: const Padding(padding: EdgeInsets.all(10), child: Icon(Icons.remove)),
                          ))),
                  const SizedBox(
                    width: AppDimension.kSizedBoxWidth,
                  ),
                  Expanded(
                      child: AppTextInput(
                    controller: _numMonthEditingController,
                    hintText: 'Thời hạn',
                    labelText: 'Thời hạn',
                    keyboardType: TextInputType.number,
                    validateType: ValidateType.numMonth,
                  )),
                  const SizedBox(
                    width: AppDimension.kSizedBoxWidth,
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            onTap: () {
                              onAddSubtractNumMonth(true);
                            },
                            child: const Padding(padding: EdgeInsets.all(10), child: Icon(Icons.add)),
                          ))),
                ],
              ),
              const SizedBox(
                height: AppDimension.kMediumSizedBoxHeight,
              ),
              GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, Routes.subcriptionPayment, arguments: [state.dataList![selectedIndexSubcription ?? 0], curNumMonth]);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 25),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.boxBorder),
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Thanh toán',
                        style: TextStyle(
                            color: Colors.white, fontSize: AppBloc.applicationCubit.appTextStyle.normal.fontSize, fontWeight: FontWeight.w700),
                      ),
                      Text('${UtilCommon.formatCommaInt(totalPrice)} đ',
                          style: TextStyle(
                              color: Colors.white, fontSize: AppBloc.applicationCubit.appTextStyle.normal.fontSize, fontWeight: FontWeight.w700))
                    ],
                  ),
                ),
              ),
            ])),
        const SizedBox(
          height: AppDimension.kMediumSizedBoxHeight,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 2.0),
          child: InkWell(
            onTap: () {
              // AppBloc.authenticationCubit.onChangeAuthenticationState(AuthenticationState.onLogin);
              // Navigator.pushReplacementNamed(context, Routes.subcriptionPending,
              //     arguments: false);
              BlocProvider.of<AppContainerNewUserCubit>(context).showNotBelongToAnyGroup();
            },
            child: Text(
              'Tôi không muốn đăng ký đội nhóm',
              style: TextStyle(
                fontSize: AppTextStyle.smallFontSize,
                color: AppColors.primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      leadingWidth: 0,
      leading: const SizedBox(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          InkWell(
            splashColor: Colors.white,
            highlightColor: Colors.white,
            onTap: () {
              AppBloc.appContainerNewUserCubit.state.scaffoldKey.currentState?.openDrawer();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.boxBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.menu, color: Color(0xFF374957)),
            ),
          ),
          const Expanded(child: SizedBox()),
          Text(
            'Đăng ký đại lý',
            style: AppBloc.applicationCubit.appTextStyle.mediumBold,
          ),
          const Expanded(child: SizedBox()),
          Text('    ')
        ],
      ),
    );
  }
}
