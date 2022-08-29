import 'package:equatable/equatable.dart';

class Post extends Equatable{
  int? userId;
  int? id;
   String? title;
 String? body;

  Post({this.userId, this.id,  this.title,  this.body});

  @override
  List<Object?> get props => [userId,id,title,body];

}