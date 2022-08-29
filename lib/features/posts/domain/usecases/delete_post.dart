import 'package:dartz/dartz.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/repository/post_reponsitory.dart';

import '../../../../core/error/failures.dart';

class DeletePost{
  final PostReponsitory postReponsitory;

  DeletePost(this.postReponsitory);
  Future<Either<Failure,Unit>> call(int postId) async{
    return await postReponsitory.deletePost(postId);
  }
}