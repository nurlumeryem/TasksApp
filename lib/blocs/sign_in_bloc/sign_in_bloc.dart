import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasks_app/blocs/sign_in_bloc/sign_in_bloc_event.dart';
import 'package:tasks_app/blocs/sign_in_bloc/sign_in_bloc_state.dart';
import 'package:user_repository/user_repository.dart';

class SignInBloc extends Bloc<SignInBlocEvent, SignInBlocState> {
  final UserRepository _userRepository;

  SignInBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(SignInBlocInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignInFailure(message: e.code));
      } catch (e) {
        emit(const SignInFailure());
      }
    });

    on<SignOutRequired>((event, emit) async {
      await _userRepository.logOut();
      emit(SignInBlocInitial()); // Logout sonrası başlangıç durumuna dönüyoruz
    });
  }
}
