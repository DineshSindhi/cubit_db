import 'package:bloc_provider/Database.dart';

class NoteModel{
  String title;
  String desc;
  String createAt;
  int id;
  NoteModel({required this.title,required this.desc,required this.createAt,this.id=0});

  factory NoteModel.fromMap(Map<String,dynamic>map){
    return NoteModel(
        id: map[MyAppDb.TABLE_KEY_ID],
        title: map[MyAppDb.TABLE_KEY_TITLE],
        desc: map[MyAppDb.TABLE_KEY_DESC],
        createAt: map[MyAppDb.TABLE_KEY_TIME]
    );
  }
  Map<String,dynamic>toMap(){
    return {
      MyAppDb.TABLE_KEY_TITLE:title,
      MyAppDb.TABLE_KEY_DESC:desc,
      MyAppDb.TABLE_KEY_TIME:createAt,
    };
  }

}