part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable{
  const PostsState();

  @override
  List<Object> get props =>[];
}

class PostsInitial extends PostsState {}
class LoadingPost extends PostsState{}
class LoadedPost extends PostsState{
  final List<Post> posts;
  LoadedPost({required this.posts});
  @override
  List<Object> get props =>[posts];
}
class ErrorPost extends PostsState{
  final String message;
  ErrorPost({required this.message});
  @override
  List<Object> get props =>[message];
}