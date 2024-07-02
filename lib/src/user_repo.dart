import 'package:tasks_app/src/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Stream<User?> get user;

  Future<UserModel> signUp(UserModel user, String password);

  Future<void> setUserData(UserModel user);

  Future<void> signIn(String email, String password);
}
