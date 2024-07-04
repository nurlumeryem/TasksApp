import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class MyUser extends Equatable {
  final String userId;
  final String name;
  final String email;

  const MyUser({required this.userId, required this.email, required this.name});

  //, bazı senaryolarda kullanıcı nesnesinin varsayılan bir değeri olarak kullanabileceğiniz sabit bir nesne sağlar.
  static const empty = MyUser(userId: '', email: '', name: '');

  MyUser copyWith({
    String? userId,
    String? name,
    String? email,
  }) {
    return MyUser(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  UserEntity toEntity() {
    return UserEntity(userId: userId, email: email, name: name);
  }

  static MyUser fromEntity(UserEntity entity) {
    return MyUser(
        userId: entity.userId, email: entity.email, name: entity.name);
  }

  @override
  List<Object?> get props => [userId, email, name];
}
