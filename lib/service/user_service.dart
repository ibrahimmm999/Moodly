import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moodly/models/user_model.dart';

class UserService {
  final CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      await _userReference.doc(user.id).set(user.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserbyId(String id) async {
    try {
      DocumentSnapshot docUser = await _userReference.doc(id).get();

      return UserModel.fromJson(docUser.data() as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> usernameCheck(
      {required String username, required bool isEdit}) async {
    final result =
        await _userReference.where("username", isEqualTo: username).get();
    if (isEdit) {
      if (result.docs.isEmpty) {
        return true;
      } else if (result.docs.length == 1) {
        return result.docs.first['id'] ==
            FirebaseAuth.instance.currentUser!.uid;
      } else {
        return false;
      }
    } else {
      return result.docs.isEmpty;
    }
  }

  Future<void> editProfile(
      String id, String name, String username, String photoUrl) async {
    try {
      DocumentReference docUser = _userReference.doc(id);
      await docUser.update({
        'name': name,
        'username': username,
        'photoUrl': photoUrl,
      });
    } catch (e) {
      rethrow;
    }
  }
}
