// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatMessage {
  final String id;
  final String text;
  final DateTime createdAt;
  final String userId;
  final String userName;
  final String userImageUrl;

  ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });

  ChatMessage copyWith({
    String? id,
    String? text,
    DateTime? createdAt,
    String? userId,
    String? userName,
    String? userImageUrl,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userImageUrl: userImageUrl ?? this.userImageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] as String,
      text: map['text'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      userImageUrl: map['userImageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromJson(String source) =>
      ChatMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatMessage(id: $id, text: $text, createdAt: $createdAt, userId: $userId, userName: $userName, userImageUrl: $userImageUrl)';
  }

  @override
  bool operator ==(covariant ChatMessage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.createdAt == createdAt &&
        other.userId == userId &&
        other.userName == userName &&
        other.userImageUrl == userImageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        createdAt.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        userImageUrl.hashCode;
  }
}
