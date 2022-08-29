import 'package:noteapp_bloc_architecture/features/posts/domain/entities/post.dart';

class PostModel extends Post{
  PostModel({int? userId,int? id, required String title, required String body}) : super(id: id, title: title, body: body);
  PostModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}