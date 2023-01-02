import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moodly/models/user_model.dart';
import 'package:moodly/service/auth_service.dart';
import 'package:moodly/service/image_service.dart';
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
      bool isUsernameUsed = !(await UserService().usernameCheck(username, 0));
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

  void updateUser({
    required File? image,
    required String id,
    required String name,
    required String username,
    required String photoUrlState,
    required String tempPhoto,
  }) async {
    emit(AuthLoading());
    ImageTool imageTool = ImageTool();

    String newPhotoUrl = '';

    if (name.isEmpty || username.isEmpty) {
      emit(const AuthFailed('Fullname and Username is Required'));
    } else {
      try {
        bool isUsernameUsed = !(await UserService()
            .usernameCheck(username, 1)); // 1 untuk dirinya sendiri

        if (isUsernameUsed) {
          emit(const AuthFailed('Username Tidak Tersedia'));
        } else {
          // ganti foto
          if (image != null) {
            // jika udah ada foto
            if (tempPhoto.isNotEmpty) {
              await imageTool.deleteImage(tempPhoto);
            }
            await imageTool.uploadImage(image, 'user');
            newPhotoUrl = imageTool.imageUrl!;
          } else {
            // tidak hapus (tetap)
            if (photoUrlState.isNotEmpty) {
              newPhotoUrl = photoUrlState;
            } else {
              if (tempPhoto.isNotEmpty) {
                await imageTool.deleteImage(tempPhoto);
              }
            }
          }

          UserModel user =
              await UserService().updateUser(id, name, username, newPhotoUrl);

          emit(AuthSuccess(user));
        }
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    }
  }
}
