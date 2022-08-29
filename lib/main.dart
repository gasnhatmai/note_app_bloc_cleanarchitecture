import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp_bloc_architecture/core/app_thems.dart';
import 'package:noteapp_bloc_architecture/features/posts/data/repository/post_responsitoryimp.dart';
import 'package:noteapp_bloc_architecture/features/posts/domain/usecases/get_all_posts.dart';
import 'package:noteapp_bloc_architecture/features/posts/presentations/blocs/add_delete_update/add_delete_updata_bloc.dart';
import 'package:noteapp_bloc_architecture/features/posts/presentations/blocs/bloc/posts_bloc.dart';
import 'package:noteapp_bloc_architecture/features/posts/presentations/pages/postpage.dart';
import 'injection_container.dart' as di;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create:(_)=>di.sl<PostsBloc>()..add(GetAllPostEvent())
        ),
        BlocProvider(
            create: (_)=>di.sl<AddDeleteUpdataBloc>()
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme:appTheme,
        home:  PostPage(),
      ),
    );
  }
}


