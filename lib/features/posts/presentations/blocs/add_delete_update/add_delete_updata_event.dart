part of 'add_delete_updata_bloc.dart';

@immutable
abstract class AddDeleteUpdataEvent extends Equatable{
  const AddDeleteUpdataEvent();

  @override
  List<Object> get props =>[];
}
class AddPostEvent extends AddDeleteUpdataEvent{
  final Post post;
   AddPostEvent({required this.post});
  @override
  List<Object> get props =>[post];
}
class DeletePostEvent extends AddDeleteUpdataEvent{
  final int postId;
  DeletePostEvent({required this.postId});
  @override
  List<Object> get props =>[postId];
}
class UpdatePostEvent extends AddDeleteUpdataEvent{
  final Post post;
  UpdatePostEvent({required this.post});
  @override
  List<Object> get props =>[post];
}
