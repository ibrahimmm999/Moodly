import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<bool> usernameCheck(String username) async {
    final result =
        await _userReference.where("username", isEqualTo: username).get();
    return result.docs.isEmpty;
  }
}
