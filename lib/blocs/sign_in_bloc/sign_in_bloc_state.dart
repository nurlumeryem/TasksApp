import 'package:equatable/equatable.dart';

abstract class SignInBlocState extends Equatable {
  const SignInBlocState();

  @override
  List<Object?> get props => [];
}

class SignInBlocInitial extends SignInBlocState {}

class SignInSuccess extends SignInBlocState {}

class SignInFailure extends SignInBlocState {
  final String? message;
  const SignInFailure({this.message});
}

class SignInProcess extends SignInBlocState {}
