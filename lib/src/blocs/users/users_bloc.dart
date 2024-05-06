import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:red_social/src/services/posts_service.dart';
import 'package:red_social/src/services/users_service.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {

  final PostsService postsService;
  final UsersService usersService;

  UsersBloc({
    required this.postsService,
    required this.usersService
  }) : super( const UsersState() ) {

    on<UsersEvent>((event, emit) { });
    on<SelectedUserEvent>( _onSelectedUser );
    on<GetUsersEvent>( _onGetUsers );
    on<SendRequestEvent>( _onSendRequest );

    _init();
  }

  _init(){
    add( GetUsersEvent() );
  }

  FutureOr<void> _onSelectedUser(SelectedUserEvent event, Emitter<UsersState> emit) async {

    final posts = await postsService.getPostsByUserId( uid: event.uid );
    final user = await usersService.getUserInfo( uid: event.uid );

    if( user != null ){
      emit( state.copyWith( users: [], posts: posts ));
    }else{
      emit( state.copyWith(users: [], posts: [] ));
    }

  }


  FutureOr<void> _onGetUsers(GetUsersEvent event, Emitter<UsersState> emit) async {
    final users = await usersService.getUsers();
    emit( state.copyWith( users: users ) );
  }

  FutureOr<void> _onSendRequest(SendRequestEvent event, Emitter<UsersState> emit) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final myProfile = await usersService.getUserInfo(uid: uid);

    if( myProfile != null ){
      usersService.sendRequest(uid: event.uid, myProfile: myProfile );
    }

  }

}
