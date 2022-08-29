part of 'add_delete_updata_bloc.dart';

@immutable
abstract class AddDeleteUpdataState extends Equatable {
  const AddDeleteUpdataState();

  @override
  List<Object> get props =>[];
}

class AddDeleteUpdataInitial extends AddDeleteUpdataState {}
class LoadingAddDeleteUpdatePost extends AddDeleteUpdataState{}
class ErrorAddDeleteUpdatePost extends AddDeleteUpdataState{
  final String message;
  const ErrorAddDeleteUpdatePost({required this.message});
  @override
  List<Object> get props =>[message];
}
class MessageAddUpdateDeletePost extends AddDeleteUpdataState{
  final String message;
  const MessageAddUpdateDeletePost({required this.message});
  @override
  List<Object> get props =>[message];
}