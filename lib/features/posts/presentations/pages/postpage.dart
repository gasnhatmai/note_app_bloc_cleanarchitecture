import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp_bloc_architecture/features/posts/presentations/blocs/bloc/posts_bloc.dart';

import '../widgets/loading_widget.dart';
import '../widgets/messagedisplaywidget.dart';
import '../widgets/post_list_widget.dart';
class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
      ),
      body: buildBody(),
    );
  }
}
Widget buildBody(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<PostsBloc,PostsState>(
          builder: (context, state) {
            if(state is LoadingPost){
              return const LoadingWidget();
            }else if(state is LoadedPost){
              return PostListWidget(posts:state.posts);
            }else if (state is ErrorPost){
              return MessageDisplayWidget(message:state.message);
            }
            return const LoadingWidget();
          }),
    );
  }

