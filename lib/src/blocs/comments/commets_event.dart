part of 'commets_bloc.dart';

abstract class CommetsEvent extends Equatable {
  const CommetsEvent();
  @override
  List<Object> get props => [];
}

class OpenCommentsEvent extends CommetsEvent{}

class LoadCommentsEvent extends CommetsEvent{
  final PostModel post;
  const LoadCommentsEvent(this.post);
}
