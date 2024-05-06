part of 'commets_bloc.dart';

class CommetsState extends Equatable {

  const CommetsState({
    this.comments = const [],
    this.openComents = false,
    this.isLoading = false
  });

  final List comments;
  final bool openComents;
  final bool isLoading;

  CommetsState copyWith({
    List? comments,
    bool? openComents,
    bool? isLoading
  }) => CommetsState(
    comments: comments ?? this.comments,
    openComents: openComents ?? this.openComents,
    isLoading: isLoading ?? this.isLoading
  );
  
  @override
  List<Object> get props => [
    comments,
    openComents,
    isLoading,
  ];
}

