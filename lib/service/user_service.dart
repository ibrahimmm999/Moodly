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

  Future<bool> usernameCheck(String username, int number) async {
    final result =
        await _userReference.where("username", isEqualTo: username).get();
    return result.docs.length <= number;
  }

  Future<UserModel> updateUser(
      String id, String name, String username, String photoUrl) async {
    try {
      DocumentReference docUser = _userReference.doc(id);
      await docUser.update({
        'name': name,
        'username': username,
        'photoUrl': photoUrl,
      });

      return await getUserbyId(id);
    } catch (e) {
      rethrow;
    }
  }
}
