import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/gestures.dart';
import 'package:red_social/src/services/cloudinary_service.dart';
import 'package:red_social/src/services/posts_service.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {

  final PostsService postsService;
  final CloudinaryService cloudinaryService;

  PostBloc({
    required this.postsService,
    required this.cloudinaryService
  }) : super( const PostState() ) {

    on<SubmitPostEvent>( _onSubmitPost );
    on<GetPostsEvent>( _onGetPostsEvent );
    on<ResetMessageEvent>( _onResetMessageEvent );
    on<ReactionPostEvent>( _onReactionPostEvent );

    _init();
  }

  _init(){
    add( GetPostsEvent() );
  }


  FutureOr<void> _onSubmitPost(SubmitPostEvent event, Emitter<PostState> emit) async{
    emit( state.copyWith(isLoading: true ) );

    final imgs = event.postModel.imgs;

    for (var img in imgs) {
      // subir imagen y cambiar el valor del img
      final upload = await cloudinaryService.uploadImage(path: img.img );
      if( upload != null && upload.isNotEmpty ){
        img.img = upload;
      }
    }
    
    final uid = await postsService.createPost( postModel: event.postModel );
    if( uid.isNotEmpty ){
      emit( state.copyWith(isLoading: false, posts: [ event.postModel..uid = uid ,...state.posts ],status: TypeState.loaded , message: 'Publicado.' ) );
    }else{
      emit( state.copyWith( isLoading: false, status: TypeState.error ,message: 'No se creo la publicación' ) );
    }
  }

  FutureOr<void> _onGetPostsEvent(GetPostsEvent event, Emitter<PostState> emit) async {
    emit( state.copyWith(isLoading: true ) );
    final data = await postsService.getPosts();
    //return data.docs.map(( doc ) => PostModel.fromJson( doc.data() ) ).toList();
    emit( state.copyWith(isLoading: false, posts: data ) );
  }

  FutureOr<void> _onResetMessageEvent(ResetMessageEvent event, Emitter<PostState> emit) {
    emit( state.copyWith( message: '', status: TypeState.initial, isLoading: false ));
  }

  FutureOr<void> _onReactionPostEvent(ReactionPostEvent event, Emitter<PostState> emit) {
    emit( state.copyWith(  isLoading: true ));
    postsService.reactionToPost( postModel: event.postModel, userId: '' );
    emit( state.copyWith(  isLoading: false ));
  }
}
