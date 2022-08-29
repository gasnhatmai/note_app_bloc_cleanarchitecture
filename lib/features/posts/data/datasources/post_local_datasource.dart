import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:noteapp_bloc_architecture/core/error/exceptions.dart';
import 'package:noteapp_bloc_architecture/features/posts/data/model/post_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource{
  Future<List<PostModel>> getCaches();
  Future<Unit> cachePosts(List<PostModel> postModel);
}
const CACHES_POSTS="CACHES_POSTS";
class PostLocalPostImp implements PostLocalDataSource{

  final SharedPreferences sharedPreferences;

  PostLocalPostImp({required this.sharedPreferences});

  @override
  Future<Unit> cachePosts(List<PostModel> postModel) {
   List postModelToJson=
   postModel.map<Map<String,dynamic>>((postModel)=>postModel.toJson()).toList();
   sharedPreferences.setString(CACHES_POSTS, json.encode(postModelToJson));
   return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCaches() {
   final jsonString=sharedPreferences.getString(CACHES_POSTS);
   if(jsonString!=null){
     List jsonDecode=json.decode(jsonString);
     List<PostModel> jsonToPostModel=
     jsonDecode.
     map<PostModel>((jsonPostModel)=>PostModel.fromJson(jsonPostModel)).
     toList();
     return Future.value(jsonToPostModel);
   }else{
     throw EmptyCacheException();
   }
  }
  
}