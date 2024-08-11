import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ngdemo11/pages/post_detail_page.dart';
import 'package:ngdemo11/service/sql_service.dart';

import '../model/member_model.dart';
import '../model/post_model.dart';
import '../service/hive_service.dart';
import 'details_page.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Post> posts = [];
  String name = "no name";

  _callDetailsPage() async {
    var result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PostDetailPage();
    }));

    if (result) {
      _loadPost();
    }
  }

  _loadPost() async {
    var postList = await SqlService.fetchPosts();
    setState(() {
      this.posts = postList;
    });
    print(posts.length);
  }

  @override
  void initState() {
    super.initState();
    // Post post = Post(title: "Iphone", body: "Swift");
    // SqlService.createPost(post);
    _loadPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("SQL - SQLite"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return _itemOfMember(posts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _callDetailsPage();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _itemOfMember(Post posts) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(top: 5),
      height: 100,
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(posts.title!,
            style: TextStyle(
              fontSize: 20,
            )),
        Text(
          posts.body!,
          style: TextStyle(fontSize: 20),
        ),
      ]),
    );
  }
}
