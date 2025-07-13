import 'package:bloc/bloc.dart';
import 'package:graduationproject/core/constants/imports.dart';
import 'package:graduationproject/features/auth/presentation/controller/cubits/forget_password_cubit/pin_code_cubit.dart';

class ConfirmationCodeViewBody extends StatefulWidget {
  const ConfirmationCodeViewBody({super.key});

  @override
  State<ConfirmationCodeViewBody> createState() =>
      _ConfirmationCodeViewBodyState();
}

class _ConfirmationCodeViewBodyState extends State<ConfirmationCodeViewBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<PinCodeCubit>();
    return Stack(
      children: [
        const BackgroundContainer(),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.35),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(45)),
                  ),
                  child: Column(
                    children: [
                      AutoSizeText(
                        minFontSize: 0,
                        S.of(context).forgot_password,
                        style: AppStyles.text25Bold
                            .copyWith(fontSize: 21, color: Colors.black),
                      ),
                      const SizedBox(height: 20),
                      AutoSizeText(
                        minFontSize: 0,
                        S.of(context).enter_received_code,
                        style: AppStyles.text24SemiBold
                            .copyWith(fontSize: 12, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<PinCodeCubit, PinCodeState>(
                        buildWhen: (previous, current) =>
                        current is VerificationValidationState ||
                            current is VerificationInitial,
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              return Container(
                                width: 60,
                                height: 60,
                                margin:
                                const EdgeInsets.symmetric(horizontal: 10),
                                child: TextField(
                                  controller: cubit.controllers[index],
                                  focusNode: cubit.focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: cubit.hasError[index] &&
                                            cubit.isValidated
                                            ? Colors.red
                                            : Colors.blue,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: '',
                                  ),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty && index < 3) {
                                      FocusScope.of(context).requestFocus(
                                          cubit.focusNodes[index + 1]);
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).requestFocus(
                                          cubit.focusNodes[index - 1]);
                                    }
                                  },
                                ),
                              );
                            }),
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                            minFontSize: 0,
                            S.of(context).didnt_receive_code,
                          ),
                          TextButton(
                              onPressed: () {
                                cubit.resendCode(context: context);
                              },
                              child: AutoSizeText(
                                minFontSize: 0,
                                S.of(context).resend,
                              )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        textStyle: AppStyles.text18Button,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          cubit.verifyCode(context: context);
                        },
                        text: S.of(context).confirm,
                        backgroundColor: AppColors.secondaryColor,
                        style: AppStyles.buttonStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}