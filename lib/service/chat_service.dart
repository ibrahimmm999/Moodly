import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moodly/models/help_chat_model.dart';
import 'package:moodly/models/support_chat_model.dart';

class ChatService {
  final CollectionReference<Map<String, dynamic>> _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> addSupportChat(SupportChatModel supportChat, String id) async {
    try {
      await _userReference.doc(id).update({
        'supportChatList': FieldValue.arrayUnion([supportChat.toJson()])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addHelpChat(HelpChatModel helpChat, String id) async {
    try {
      await _userReference.doc(id).update({
        'helpChatList': FieldValue.arrayUnion([helpChat.toJson()])
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateHelpStatus(String id, bool status) async {
    try {
      DocumentSnapshot user = await _userReference.doc(id).get();

      List array =
          (user.data() as Map<String, dynamic>)['helpChatList'].toList();

      array.last['isCompleted'] = status;

      await _userReference.doc(id).update({'helpChatList': array});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateRecomendation(String id, bool status) async {
    try {
      DocumentSnapshot user = await _userReference.doc(id).get();

      List array =
          (user.data() as Map<String, dynamic>)['helpChatList'].toList();

      array.last['isRecomendation'] = status;

      await _userReference.doc(id).update({'helpChatList': array});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateRead(String id, bool isHelpChat) async {
    try {
      DocumentSnapshot user = await _userReference.doc(id).get();

      if (isHelpChat) {
        List array =
            (user.data() as Map<String, dynamic>)['helpChatList'].toList();
        for (var element in array) {
          element['isRead'] = true;
        }
        await _userReference.doc(id).update({'helpChatList': array});
      } else {
        List array =
            (user.data() as Map<String, dynamic>)['supportChatList'].toList();
        for (var element in array) {
          element['isRead'] = true;
        }
        await _userReference.doc(id).update({'supportChatList': array});
      }
    } catch (e) {
      rethrow;
    }
  }
}
