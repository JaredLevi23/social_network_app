part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}


class ChangeEmailEvent extends AuthEvent{
  final String email;
  const ChangeEmailEvent({ required this.email});
}

class ChangePasswordEvent extends AuthEvent{
  final String password;
  const ChangePasswordEvent({ required this.password});
}


class ResetFieldsEvent extends AuthEvent{}

class SubmitFieldsEvent extends AuthEvent{}

class CreateUserEvent extends AuthEvent{}

class ResetMessageEvent extends AuthEvent{}

class SendEmailResetPasswordEvent extends AuthEvent{}

class LoginWithGoogleEvent extends AuthEvent{}