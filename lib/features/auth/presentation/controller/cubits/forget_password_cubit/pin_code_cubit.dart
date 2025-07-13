import 'package:graduationproject/core/constants/imports.dart';

import '../../../../../../core/constants/sensitive_strings.dart';
import '../../../../data/models/forget_password/code_request.dart';
import '../../../../data/models/forget_password/email_request.dart';

part 'pin_code_state.dart';

class PinCodeCubit extends Cubit<PinCodeState> {
  PinCodeCubit({required this.authRepo}) : super(VerificationInitial());
  final AuthRepo authRepo;

  final List<TextEditingController> controllers = List.generate(
      4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  List<bool> hasError = List.generate(4, (_) => false);
  bool isValidated = false;

  Future<void> verifyCode({required BuildContext context}) async {
    bool hasEmptyField = false;
    isValidated = true;

    final email = CacheHelper.getString(key: SensitiveStrings.resetPasswordEmailKey);
    if (email == null || email.isEmpty) {
      emit(VerificationValidationState());
      emit(VerificationFailureState(message: S.of(context).enter_email));
      return;
    }

    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      emit(VerificationValidationState());
      emit(VerificationFailureState(message: S.of(context).enter_valid_email));
      return;
    }

    for (int i = 0; i < controllers.length; i++) {
      hasError[i] = controllers[i].text.isEmpty;
      if (hasError[i]) {
        hasEmptyField = true;
      }
    }

    emit(VerificationValidationState());

    if (hasEmptyField) {
      emit(VerificationFailureState(message: S.of(context).this_field_is_required));
      return;
    }

    String codeString = '';
    for (var controller in controllers) {
      codeString += controller.text;
    }

    int? code = int.tryParse(codeString);
    if (code == null) {
      emit(VerificationFailureState(message: S.of(context).invalid_code));
      return;
    }

    emit(VerificationLoadingState());
    final result = await authRepo.verifyCode(
        verifyCodeRequest: VerifyCodeRequest(code: code, email: email));
    result.fold(
          (failure) => emit(VerificationFailureState(message: failure.message)),
          (success) => emit(VerificationSuccessState()),
    );
  }

  Future<void> resendCode({required BuildContext context}) async {
    final email = CacheHelper.getString(key: SensitiveStrings.resetPasswordEmailKey);
    if (email == null || email.isEmpty) {
      emit(VerificationFailureState(message: S.of(context).enter_email));
      return;
    }
    emit(VerificationLoadingState());
    final result = await authRepo.resendCode(
        forgetPasswordRequest: ForgetPasswordRequest(email: email));
    result.fold(
            (failure) => emit(VerificationFailureState(message: failure.message)),
            (success) => emit(VerificationInitial()));
  }

  @override
  Future<void> close() async {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    await super.close();
  }
}