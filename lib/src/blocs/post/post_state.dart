part of 'post_bloc.dart';

enum TypeState{
  initial,
  loaded,
  loading,
  error
}

 class PostState extends Equatable {

  const PostState({
    this.posts = const [],
    this.isLoading = false,
    this.status = TypeState.initial,
    this.message = ''
  });
  
  final List<PostModel> posts;
  final bool isLoading;
  final TypeState status;
  final String message;

  PostState copyWith({
    List<PostModel>? posts,
    bool? isLoading,
    TypeState? status,
    String? message
  }){
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts,
      status: status ?? this.status,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [
    posts,
    isLoading,
    status,
    message
  ];
}
