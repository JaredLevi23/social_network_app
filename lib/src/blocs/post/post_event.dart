part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}


class SubmitPostEvent extends PostEvent{
  final PostModel postModel;
  const SubmitPostEvent({ required this.postModel});
}

class GetPostsEvent extends PostEvent{}

class ReactionPostEvent extends PostEvent{
  final PostModel postModel;
  const ReactionPostEvent({ required this.postModel});

}

class ResetMessageEvent extends PostEvent{}