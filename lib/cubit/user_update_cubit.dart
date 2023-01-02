import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moodly/service/image_service.dart';
import 'package:moodly/service/user_service.dart';

part 'user_update_state.dart';

class UserUpdateCubit extends Cubit<UserUpdateState> {
  UserUpdateCubit() : super(UserUpdateInitial());

  void editProfile({
    required File? image,
    required String id,
    required String name,
    required String username,
    required String photoUrlState,
    required String tempPhoto,
  }) async {
    emit(UserUpdateLoading());
    ImageTool imageTool = ImageTool();

    String newPhotoUrl = '';

    if (name.isEmpty || username.isEmpty) {
      emit(const UserUpdateFailed('Fullname and Username is Required'));
    } else {
      try {
        bool isUsernameUsed = !(await UserService()
            .usernameCheck(username: username, isEdit: true));

        if (isUsernameUsed) {
          emit(const UserUpdateFailed('Username Tidak Tersedia'));
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

          await UserService().editProfile(id, name, username, newPhotoUrl);

          emit(UserUpdateSuccess());
        }
      } catch (e) {
        emit(UserUpdateFailed(e.toString()));
      }
    }
  }
}
