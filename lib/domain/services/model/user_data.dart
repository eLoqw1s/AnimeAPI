import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String userId;
  final String name;
  final String email;
  final String description;
  final DateTime timestamp;

  UserData({
    required this.userId,
    required this.name,
    required this.email,
    this.description = '',
    required this.timestamp,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      description: json['description'] as String? ?? '',
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'description': description,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}