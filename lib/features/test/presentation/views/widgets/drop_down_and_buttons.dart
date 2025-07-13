import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/core/utils/dimensions.dart';
import 'package:graduationproject/features/test/presentation/views/widgets/selected_test_buttons_row.dart';
import 'package:graduationproject/generated/l10n.dart';
import '../../controller/cubits/tests_cubit/tests_cubit.dart';
import 'dropdownmenu.dart';

class DropDownAndButtons extends StatelessWidget {
  const DropDownAndButtons({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.paddingLarge),
              child: AutoSizeText(
                S.of(context).which_test_to_take,
                style: AppStyles.text25Bold.copyWith(color: AppColors.secondaryColor),
                minFontSize: 14,
                stepGranularity: 1,
              ),
            ),
            BlocBuilder<TestsCubit, TestsState>(
              buildWhen: (previous, current) => current is TestsSuccess,
              builder: (context, state) {
                return DropDownMenu(
                  onChanged: (value) {
                    context.read<TestsCubit>().selected = value!;
                    context.read<TestsCubit>().getSelectedTestDataObject();
                  },
                  items: context.read<TestsCubit>().listOfTestsName,
                  selectedItem: context.read<TestsCubit>().selected ,
                );
              },
            ),
            SizedBox(height: Dimensions.boxHeight20),
            SelectedTestButtons(formKey: formKey),
          ],
        ),
      ),
    );
  }
}