import 'package:dartz/dartz.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/repository/post_reponsitory.dart';

import '../../../../core/error/failures.dart';
import '../entities/post.dart';

class GetAllPosts {
  final PostReponsitory postReponsitory;

  GetAllPosts(this.postReponsitory);
  Future<Either<Failure,List<Post>>> call() async{
   return await postReponsitory.getAllPost();
  }
}