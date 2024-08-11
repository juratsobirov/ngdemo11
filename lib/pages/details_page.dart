import 'package:flutter/material.dart';

import '../model/member_model.dart';
import '../service/hive_service.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerName = TextEditingController();


  _addMemberToDB(){
    String idString = controllerId.text.trim().toString();
    String username = controllerName.text.trim().toString();
    int id = int.parse(idString);
    Member member = Member(id, username);

    HiveService.saveMember(member);

    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Add Member"),
      ),
        body: Container(
          padding:EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: controllerId,
                decoration: InputDecoration(
                  hintText: "Input member id",
                ),
              ),
              SizedBox(height:10),
              TextField(
                controller: controllerName,
                decoration: InputDecoration(
                  hintText: "Input member name",
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
