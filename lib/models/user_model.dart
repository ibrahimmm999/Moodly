import 'package:equatable/equatable.dart';
import 'package:moodly/models/help_chat_model.dart';
import 'package:moodly/models/mood_data.dart';
import 'package:moodly/models/support_chat_model.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String username;
  final String photoUrl;
  final String role;
  final List<SupportChatModel> supportChatList;
  final List<HelpChatModel> helpChatList;
  final List<MoodDataModel> moodDataList;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    this.photoUrl = '',
    this.role = 'user',
    required this.supportChatList,
    required this.helpChatList,
    required this.moodDataList,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
      photoUrl: json['photoUrl'],
      role: json['role'],
      supportChatList: List<SupportChatModel>.from(
          json['supportChatList'].map((x) => SupportChatModel.fromJson(x))),
      helpChatList: List<HelpChatModel>.from(
          json['helpChatList'].map((x) => HelpChatModel.fromJson(x))),
      moodDataList: List<MoodDataModel>.from(
          json['moodDataList'].map((x) => MoodDataModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'username': username,
        'photoUrl': photoUrl,
        'role': role,
        'supportChatList':
            List<dynamic>.from(supportChatList.map((x) => x.toJson())),
        'helpChatList': List<dynamic>.from(helpChatList.map((x) => x.toJson())),
        'moodDataList': List<dynamic>.from(moodDataList.map((x) => x.toJson())),
      };

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        username,
        photoUrl,
        role,
        supportChatList,
        helpChatList,
        moodDataList,
      ];
}
