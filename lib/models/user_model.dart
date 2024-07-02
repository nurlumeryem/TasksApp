import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String userId;
  final String name;
  final String email;

  const UserModel(
      {required this.userId, required this.email, required this.name});

  //, bazı senaryolarda kullanıcı nesnesinin varsayılan bir değeri olarak kullanabileceğiniz sabit bir nesne sağlar.
  static const empty = UserModel(userId: '', email: '', name: '');

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [userId, email, name];
}
