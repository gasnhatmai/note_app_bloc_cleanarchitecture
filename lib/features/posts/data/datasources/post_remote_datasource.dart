import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:noteapp_bloc_architecture/core/error/exceptions.dart';
import 'package:noteapp_bloc_architecture/features/posts/data/model/post_model.dart';

import '../../domain/entities/post.dart';
import 'package:http/http.dart' as http;
abstract class PostRemoteDatasource{
  Future<List<PostModel>> getAllPost();
  Future<Unit> deletePost(int id);
  Future<Unit> updatePost(Post post);
  Future<Unit> addPost(Post post);
}
const BASE_URL="https://jsonplaceholder.typicode.com";
class PostRemoteDataSourceImp implements PostRemoteDatasource{
  final http.Client client;
  PostRemoteDataSourceImp({required this.client});

  @override
  Future<Unit> addPost(Post post) async{
    final  body={
      "title":post.title,
      "body":post.body
    };
    final response=await client.post(Uri.parse(BASE_URL+"/posts/"),body: body);
    if(response.statusCode==201){
      return Future.value(unit);
    }else{
      throw ServeException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async{
    final response=await client.post(Uri.parse(BASE_URL+"/posts/${id.toString()}"),
        headers: {"Content-Type":"application/json"}
    );
    if(response.statusCode==200){
      return Future.value(unit);
    }else {
      throw ServeException();
    }
  }

  @override
  Future<List<PostModel>> getAllPost() async{
   final response=await client.get(Uri.parse(BASE_URL+"/posts/"),
   headers: {"Content-Type":"application/json"});
   if(response.statusCode==200){
     final List decodeJson=json.decode(response.body) as List;
     final List<PostModel> postModel=
     decodeJson.map<PostModel>((jsonPostModel)=>PostModel.fromJson(jsonPostModel)).toList();
     print("${response}kkkkkffkfkfkf");
     return postModel;
   }else {
     throw ServeException();
   }
  }

  @override
  Future<Unit> updatePost(Post post) async {
    final  body={
      "title":post.title,
      "body":post.body
    };
    final postId=post.id.toString();
    final response=await client.patch(Uri.parse(BASE_URL+"/posts/${postId}"),body: body);
    if(response.statusCode==200){
      return Future.value(unit);
    }else{
      throw ServeException();
    }
  }
  
}