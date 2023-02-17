import '../../models/user_model.dart';

class MessageModel {
  final String? id;
  final String content;
  final DateTime time;
  final UserModel user;

  const MessageModel({
    required this.id,
    required this.content,
    required this.time,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'time': time,
      'user': user.toJson(),
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      content: map['content'] ?? '',
      time: map['time'].toDate(),
      user: UserModel.fromJson(map['user']),
    );
  }

  MessageModel copyWith({
    String? id,
    String? content,
    DateTime? time,
    UserModel? user,
  }) {
    return MessageModel(
      id: id ?? this.id,
      content: content ?? this.content,
      time: time ?? this.time,
      user: user ?? this.user,
    );
  }
}
