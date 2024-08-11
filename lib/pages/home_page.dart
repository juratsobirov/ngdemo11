import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../model/member_model.dart';
import '../service/hive_service.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Member> members = [];
  String name = "no name";


  _clearMembers(){
    var box = Hive.box('my_nosql');
    box.clear();
  }

  _loadMember()async{
    var member = HiveService.loadMember();
    setState((){
      name = member.username;
    });
  }

  _loadMembers() {
    setState(() {
      this.members = HiveService.getAllMembers();
    });
  }

  _callDetailsPage() async{
    var result = await Navigator.of(context).push(MaterialPageRoute(builder:(BuildContext context){
      return DetailsPage();
    }));

    if(result){
      _loadMembers();
    }
  }

  @override
  void initState() {
    super.initState();

    Member member1 = Member(1002, "Jur'at");
    Member member2 = Member(1003, "Yunus");
    Member member3 = Member(1004, "Solih");

    HiveService.storeMember(member3);
    _loadMember();


    HiveService.saveMember(member1);
    HiveService.saveMember(member2);
    _loadMembers();
    // HiveService.deleteMemberByIndex(0);
    // _clearMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("NoSQL - Hive"),
      ),
      body: ListView.builder(
        itemCount:members.length,
        itemBuilder:(context, index){
          return _itemOfMember(members[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _callDetailsPage();
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor:Colors.blue,
      ),
    );
  }

  Widget _itemOfMember(Member member){
       return Container(
         padding:EdgeInsets.all(16),
         margin:EdgeInsets.only(top:5),
         height:100,
         color: Colors.white,
         child:Row(
           mainAxisAlignment:MainAxisAlignment.spaceBetween,
           children:[
             Text(member.username, style: TextStyle(fontSize:20,)),
             Text(member.id.toString(), style:TextStyle(fontSize:20),),

           ]
         ),
       );
  }
}
