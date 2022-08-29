import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:noteapp_bloc_architecture/core/error/failures.dart';
import 'package:noteapp_bloc_architecture/core/strings/strings.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/usecases/get_all_posts.dart';

import '../../../domain/entities/post.dart';



part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPosts getAllPosts;
  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if(event is GetAllPostEvent){
      emit(LoadingPost());
      final failureOrPost=await getAllPosts();
    emit(_mapFailureOrPostToState(failureOrPost));
      }else if (event is RefreshPostEvent){
    emit(LoadingPost());
    final failureOrPost=await getAllPosts();
    emit(_mapFailureOrPostToState(failureOrPost));
      }
    });
  }
  PostsState _mapFailureOrPostToState(Either<Failure,List<Post>> either){
    return either.fold(
            (failure) => ErrorPost(message:_mapFailureToMessage(failure))
            ,(posts) => LoadedPost(posts: posts));
  }
  String _mapFailureToMessage(Failure failure){
    switch(failure.runtimeType){
      case ServeFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpecture failure,Please try again";
    }
  }
}
