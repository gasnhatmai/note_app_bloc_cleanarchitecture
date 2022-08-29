import 'package:dartz/dartz.dart';
import 'package:noteapp_bloc_architecture/core/error/exceptions.dart';
import 'package:noteapp_bloc_architecture/core/error/failures.dart';
import 'package:noteapp_bloc_architecture/core/network/network_info.dart';
import 'package:noteapp_bloc_architecture/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:noteapp_bloc_architecture/features/posts/data/model/post_model.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/entities/post.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/repository/post_reponsitory.dart';

import '../datasources/post_local_datasource.dart';
typedef Future<Unit> DeleteOrUpdateOrAddPost();
class PostResponsitoryImp implements PostReponsitory{
  final PostRemoteDatasource postRemoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetWorkInfo netWorkInfo;
  PostResponsitoryImp({required this.postRemoteDataSource,
    required this.localDataSource,
     required this.netWorkInfo});

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async{
   final PostModel postModel=PostModel(id: post.id, title: post.title!, body: post.body!);
   return await _getMessage((){
     return postRemoteDataSource.addPost(postModel);
   });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage((){
      return postRemoteDataSource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPost() async {
    if(await netWorkInfo.isConnected){
      try{
    final remotePost=await postRemoteDataSource.getAllPost();
    localDataSource.cachePosts(remotePost);
    return Right(remotePost);
      } on ServeException{
        return Left(ServeFailure());
    }
    }else{
      try{
        final localPost=await localDataSource.getCaches();
        return Right(localPost);
      } on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel=PostModel(id: post.id, title: post.title!, body: post.body!);
    return await _getMessage((){
     return postRemoteDataSource.updatePost(postModel);
    });
  }
  Future<Either<Failure, Unit>> _getMessage(DeleteOrUpdateOrAddPost deleteOrUpdataOrAddPost) async{
    if(await netWorkInfo.isConnected){
      try{
        await deleteOrUpdataOrAddPost();
        return Right(unit);
      }on ServeException{
        return Left(ServeFailure());
      }
    }else{
      return Left(OfflineFailure());
    }
 }
}