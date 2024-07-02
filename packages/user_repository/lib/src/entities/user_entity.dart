import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String name;
  final String email;

  const UserEntity(
      {required this.userId, required this.email, required this.name});

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
    };
  }

  static UserEntity fromDocument(Map<String, dynamic> doc) {
    return UserEntity(
        userId: doc['userId'], email: doc['email'], name: doc['name']);
  }

  @override
  List<Object?> get props => [userId, email, name];
}
