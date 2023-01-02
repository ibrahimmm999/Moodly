import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moodly/models/user_model.dart';
import 'package:moodly/service/auth_service.dart';
import 'package:moodly/service/user_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signUp(
      {required String email,
      required String password,
      required String name,
      required String username}) async {
    try {
      emit(AuthLoading());
      bool isUsernameUsed = !(await UserService()
          .usernameCheck(username: username, isEdit: false));
      if (isUsernameUsed) {
        emit(const AuthFailed('Username Tidak Tersedia'));
      } else {
        UserModel user = await AuthService().signup(
            email: email, name: name, password: password, username: username);

        emit(AuthSuccess(user));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user =
          await AuthService().signIn(email: email, password: password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();

      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      emit(AuthLoading());
      UserModel user = await UserService().getUserbyId(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
