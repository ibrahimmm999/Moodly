import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moodly/models/consultant_model.dart';
import 'package:moodly/service/consultant_service.dart';
import 'package:moodly/service/image_service.dart';

part 'consultant_save_state.dart';

class ConsultantSaveCubit extends Cubit<ConsultantSaveState> {
  ConsultantSaveCubit() : super(ConsultantSaveInitial());

  void save({required File? image, required ConsultantModel consultant}) async {
    emit(ConsultantSaveLoading());
    ImageTool imageTool = ImageTool();
    ConsultantService consultantService = ConsultantService();

    String newPhotoUrl = '';

    if ((image == null && consultant.photoUrl.isEmpty) ||
        consultant.name.isEmpty ||
        consultant.phone.isEmpty ||
        consultant.openTime.isEmpty ||
        consultant.address.isEmpty ||
        consultant.province.isEmpty) {
      emit(const ConsultantSaveFailed('Form is Required'));
    } else {
      try {
        if (image != null) {
          if (consultant.photoUrl.isNotEmpty) {
            await imageTool.deleteImage(consultant.photoUrl);
          }
          await imageTool.uploadImage(image, 'consultant');
          newPhotoUrl = imageTool.imageUrl!;
        } else {
          newPhotoUrl = consultant.photoUrl;
        }

        if (consultant.id.isEmpty) {
          await consultantService.addConsultant(
            ConsultantModel(
              id: consultant.id,
              name: consultant.name,
              photoUrl: newPhotoUrl,
              phone: consultant.phone,
              openTime: consultant.openTime,
              address: consultant.address,
              province: consultant.province,
            ),
          );
        } else {
          await consultantService.updateConsultant(
            ConsultantModel(
              id: consultant.id,
              name: consultant.name,
              photoUrl: newPhotoUrl,
              phone: consultant.phone,
              openTime: consultant.openTime,
              address: consultant.address,
              province: consultant.province,
            ),
          );
        }
        emit(ConsultantSaveSuccess());
      } catch (e) {
        emit(ConsultantSaveFailed(e.toString()));
      }
    }
  }
}
