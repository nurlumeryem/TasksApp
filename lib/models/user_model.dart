import 'package:equatable/equatable.dart';
import 'package:tasks_app/src/entities/entities.dart';

class User extends Equatable {
  final String userId;
  final String name;
  final String email;

  const User({required this.userId, required this.email, required this.name});

  //, bazı senaryolarda kullanıcı nesnesinin varsayılan bir değeri olarak kullanabileceğiniz sabit bir nesne sağlar.
  static const empty = User(userId: '', email: '', name: '');

  User copyWith({
    String? userId,
    String? name,
    String? email,
  }) {
    return User(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  UserEntity toEntity() {
    return UserEntity(userId: userId, email: email, name: name);
  }

  static User fromEntity(UserEntity entity) {
    return User(userId: entity.userId, email: entity.email, name: entity.name);
  }

  @override
  List<Object?> get props => [userId, email, name];
}
