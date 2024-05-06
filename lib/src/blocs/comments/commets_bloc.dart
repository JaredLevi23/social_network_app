import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:red_social/src/services/comments_service.dart';
import 'package:red_social/src/services/posts_service.dart';

part 'commets_event.dart';
part 'commets_state.dart';

class CommetsBloc extends Bloc<CommetsEvent, CommetsState> {

  PostModel? model;
  final CommentsService commentsService;

  CommetsBloc({
    required this.commentsService,
    this.model
  }) : super( const CommetsState() ) {

    on<OpenCommentsEvent>( _onOpenComments );
    on<LoadCommentsEvent>( _onLoadCommentsEvent );

  }

  FutureOr<void> _onOpenComments(OpenCommentsEvent event, Emitter<CommetsState> emit) {
    final openComments = !state.openComents;
    emit( state.copyWith( openComents: openComments ) );
  }


  FutureOr<void> _onLoadCommentsEvent(LoadCommentsEvent event, Emitter<CommetsState> emit) async {
    model = event.post;
    final comments = await commentsService.getPosts( event.post.uid );
    emit( state.copyWith( comments: comments ) );
  }
}
