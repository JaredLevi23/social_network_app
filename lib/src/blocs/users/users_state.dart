part of 'users_bloc.dart';

class UsersState extends Equatable {
  
  const UsersState({
    this.posts = const [],
    this.users = const []
  });

  final List<PostModel> posts;
  final List<UserModel> users;

  UsersState copyWith({
    List<PostModel>? posts,
    List<UserModel>? users
  })=> UsersState(
    posts: posts ?? this.posts,
    users: users ?? this.users
  );
  
  @override
  List<Object> get props => [
    users,
    posts
  ];
}
