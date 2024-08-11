import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../model/member_model.dart';

class HiveService{
  static var box = Hive.box("my_nosql");

  static Future<void> init()async{
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive
      ..init(appDocumentDirectory.path)
      ..registerAdapter(MemberAdapter());

    await Hive.openBox("my_nosql");
  }

//   Save object using key and value
static storeMember(Member member){
  box.put("member", member);       //in this case it is stored in the database
}

static Member loadMember(){
  var member = box.get("member");
  return member;                //Retrieve from database
}

static removeMember() async{
     box.delete("member");   //Delete from database
}

// Save object without key

static saveMember(Member member)async{
     box.add(member);
}

static updateMember(int index, Member member) async{
    box.putAt(index, member);
}

static List<Member> getAllMembers(){
  List<Member> members = [];
  for(int i =0;i < box.length;i++){
    members.add(box.getAt(i));
  }
  return members;
}

static deleteMemberByIndex(int index){
  box.deleteAt(index);
}


}