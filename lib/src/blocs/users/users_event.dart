part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class SelectedUserEvent extends UsersEvent{
  final String uid;
  const SelectedUserEvent({ required this.uid });
}

class ChangeCurrentUserEvent extends UsersEvent{
  final UserModel user;
  const ChangeCurrentUserEvent(this.user);
}

class GetUsersEvent extends UsersEvent{}

class SendRequestEvent extends UsersEvent{
  final String uid;
  final UserModel profile;
  final List<UserModel> users;

  const SendRequestEvent({
    required this.uid, 
    required this.profile, 
    required this.users
  });
}

