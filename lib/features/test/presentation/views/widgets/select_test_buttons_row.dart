import '../../../../../core/constants/imports.dart';
import '../q_view.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              textStyle: AppStyles.text18Button,
              style: AppStyles.buttonStyle,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushNamed(context, QuestionsView.routeName);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: AutoSizeText(
                minFontSize: 0,S.of(context).please_select_test),
                    ),
                  );
                }
              },
              text: S.of(context).start_test,
              backgroundColor: AppColors.secondaryColor,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              textStyle: AppStyles.text18Button.copyWith(
                color: AppColors.secondaryColor,
              ),
              style: AppStyles.buttonStyle.copyWith(
                backgroundColor: const WidgetStatePropertyAll(
                  Colors.transparent,
                ),
              ),
              onPressed: () {},
              text: S.of(context).learn_about_test,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}