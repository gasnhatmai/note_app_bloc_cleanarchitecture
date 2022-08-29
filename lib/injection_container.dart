import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:noteapp_bloc_architecture/core/network/network_info.dart';
import 'package:noteapp_bloc_architecture/features/posts/data/datasources/post_local_datasource.dart';
import 'package:noteapp_bloc_architecture/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:noteapp_bloc_architecture/features/posts/data/repository/post_responsitoryimp.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/repository/post_reponsitory.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/usecases/add_post.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/usecases/delete_post.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/usecases/update_post.dart';
import 'package:noteapp_bloc_architecture/features/posts/presentations/blocs/add_delete_update/add_delete_updata_bloc.dart';
import 'package:noteapp_bloc_architecture/features/posts/presentations/blocs/bloc/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
final sl=GetIt.instance;
Future<void> init() async{
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdataBloc(addPost: sl(),
      updatePost: sl(),
      deletePost: sl())); 
  sl.registerLazySingleton(() => GetAllPosts(sl()));
  sl.registerLazySingleton(() => AddPost(sl()));
  sl.registerLazySingleton(() => DeletePost(sl()));
  sl.registerLazySingleton(() => UpdatePost(sl()));
  sl.registerLazySingleton<PostReponsitory>(() =>
      PostResponsitoryImp(postRemoteDataSource:sl(),
          localDataSource: sl(),
          netWorkInfo: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(() =>
      PostLocalPostImp(sharedPreferences: sl()));
  sl.registerLazySingleton<PostRemoteDatasource>(() =>
      PostRemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton<NetWorkInfo>(() => 
      NetWorkInfoImp(sl())
  );
  final sharePreference=await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharePreference);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}