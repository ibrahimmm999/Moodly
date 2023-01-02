import 'package:cloud_firestore/cloud_firestore.dart';
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
}
