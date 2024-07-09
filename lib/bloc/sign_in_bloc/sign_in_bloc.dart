import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_app/auth/firebase_user_repo.dart';
import 'package:tasks_app/auth/user_repo.dart';
import 'package:tasks_app/core/routes/routes.dart';
import 'package:tasks_app/core/routes/routes.manager.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository _userRepository = FirebaseUserRepo();

  SignInBloc() : super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
        router.go(Routes.home);
      } on FirebaseAuthException catch (e) {
        emit(SignInFailure(message: e.code));
      } catch (e) {
        emit(const SignInFailure());
      }
    });

    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
      emit(SignOutSuccess());
    });
  }
}
