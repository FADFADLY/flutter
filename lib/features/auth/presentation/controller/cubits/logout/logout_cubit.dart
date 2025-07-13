import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:graduationproject/core/constants/imports.dart';
import '../../../../domain/entities/logout_response_entity.dart';

part 'logout_state.dart';


class LogoutCubit extends Cubit<LogoutState> {
  final AuthRepo authRepo;

  LogoutCubit({required this.authRepo}) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    final response = await authRepo.logout();
    response.fold(
          (failure) => emit(LogoutError(message: failure.message)),
          (response) => emit(LogoutSuccess(logoutResponse: response)),
    );
  }
}