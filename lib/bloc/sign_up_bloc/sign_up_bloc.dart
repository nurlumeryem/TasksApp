import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks_app/auth/firebase_user_repo.dart';
import 'package:tasks_app/auth/user_repo.dart';
import 'package:tasks_app/core/routes/routes.dart';
import 'package:tasks_app/core/routes/routes.manager.dart';
import 'package:tasks_app/models/user.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository = FirebaseUserRepo();

  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        MyUser user = await _userRepository.signUp(event.user, event.password);
        // await _userRepository.setUserData(user);
        // await AuthHelper.saveUserLoggedIn(true);
        emit(SignUpSuccess());
        router.go(Routes.home);
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
