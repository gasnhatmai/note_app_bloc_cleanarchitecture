import 'package:dartz/dartz.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/repository/post_reponsitory.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class UpdatePost{
  final PostReponsitory postReponsitory;

  UpdatePost(this.postReponsitory);
  Future<Either<Failure,Unit>> call(Post post) async{
    return await postReponsitory.updatePost(post);
  }
}