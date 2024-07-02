import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_app/src/model/user_model.dart';
import 'package:tasks_app/src/user_repo.dart';

class FirebaseUserRepo implements UserRepository {
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('user');

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  @override
  Stream<User?> get user => throw UnimplementedError();

  @override
  Future<void> signIn(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUp(UserModel user, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> setUserData(UserModel user) {
    throw UnimplementedError();
  }
}
