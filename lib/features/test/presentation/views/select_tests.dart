import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/test/presentation/views/q_view.dart';
import 'package:graduationproject/features/test/presentation/views/test_view.dart';
import 'package:graduationproject/features/test/presentation/views/widgets/drop_down_and_buttons.dart';
import 'package:graduationproject/features/test/presentation/views/widgets/selected_test_buttons_row.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../../../core/shared_widgets/loading_widget.dart';
import '../../../../generated/assets.dart';
import '../../domain/repo/repo.dart';
import '../controller/cubits/tests_cubit/tests_cubit.dart';

class SelectTest extends StatelessWidget {
  const SelectTest({super.key});
  static const String routeName = '/selectTest';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => TestsCubit(testRepo: getIt<TestRepository>())..getAllTestsName(),
      child: BlocConsumer<TestsCubit, TestsState>(
        listener: (context, state) {
          // Removed ScaffoldMessenger for non-critical success message
        },
        builder: (context, testsState) {
          if (testsState is TestsLoading) {
            return LoadingWidget();
          }
          if (testsState is TestsSuccess) {
            return Scaffold(
              appBar: buildAppBar(
                backgroundColor: AppColors.secondaryColor,
                context,
                title: "",
                navigateTo: TestView.routeName,
              ),
              backgroundColor: AppColors.whiteColor,
              body: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 0.48.sh,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.borderRadiusMedium),
                          topRight: Radius.circular(Dimensions.borderRadiusMedium),
                        ),
                      ),
                      child: DropDownAndButtons(formKey: formKey),
                    ),
                  ),
                  SvgPicture.asset(
                    Assets.testsTestCuate2,
                  ),
                ],
              ),
            );
          }
          return const Placeholder();
        },
      ),
    );
  }
}