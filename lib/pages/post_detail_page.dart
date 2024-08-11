import 'package:flutter/material.dart';
import 'package:ngdemo11/service/sql_service.dart';

import '../model/member_model.dart';
import '../model/post_model.dart';
import '../service/hive_service.dart';

class PostDetailPage extends StatefulWidget {
  const PostDetailPage({super.key});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerBody = TextEditingController();


  _addMemberToDB(){
    String title = controllerTitle.text.trim().toString();
    String body = controllerBody.text.trim().toString();
    Post post = Post(title:title, body: body);

    SqlService.createPost(post);

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Add Post"),
      ),
        body: Container(
          padding:EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: controllerTitle,
                decoration: InputDecoration(
                  hintText: "Input post title",
                ),
              ),
              SizedBox(height:10),
              TextField(
                controller: controllerBody,
                decoration: InputDecoration(
                  hintText: "Input post body",
                ),
              ),
              SizedBox(height:10),
              MaterialButton(
                onPressed:(){
                _addMemberToDB();
                },
                color: Colors.blue,
                child:Text("Add", style: TextStyle(fontSize: 16, color: Colors.white),),
              ),
            ],
          ),

        ),
    );
  }
}
