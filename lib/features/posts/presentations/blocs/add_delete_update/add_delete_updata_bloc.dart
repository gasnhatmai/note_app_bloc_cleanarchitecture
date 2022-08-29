import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:noteapp_bloc_architecture/core/strings/message.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/usecases/update_post.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/strings.dart';
import '../../../domain/entities/post.dart';

part 'add_delete_updata_event.dart';
part 'add_delete_updata_state.dart';

class AddDeleteUpdataBloc extends Bloc<AddDeleteUpdataEvent, AddDeleteUpdataState> {
  final AddPost addPost;
  final UpdatePost updatePost;
  final DeletePost deletePost;
  AddDeleteUpdataBloc({required this.addPost,
    required this .updatePost,
    required this.deletePost}) : super(AddDeleteUpdataInitial()) {
    on<AddDeleteUpdataEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePost());
        final failureOrDoneMessage = await addPost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePost());
        final failureOrDoneMessage = await updatePost(event.post);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePost());
        final failureOrDoneMessage = await deletePost(event.postId);
        emit(_eitherDoneMessageOrErrorState(failureOrDoneMessage, DELETE_SUCCESS_MESSAGE));
      }
        });
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
  AddDeleteUpdataState _eitherDoneMessageOrErrorState(Either<Failure, Unit> either,String message){
    return either.fold((failure) => ErrorAddDeleteUpdatePost(
        message: _mapFailureToMessage(failure)),
            (_) => MessageAddUpdateDeletePost(message: message));
  }
}
  



