import 'package:bloc_provider/Model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyAppDb{
  MyAppDb._();
  static final MyAppDb db=MyAppDb._();

  static const String TABLE_KEY_NOTE ='note';
  static const String TABLE_KEY_ID ='id';
  static const String TABLE_KEY_TITLE ='title';
  static const String TABLE_KEY_DESC ='desc';
  static const String TABLE_KEY_TIME ='time';

  Database? myDb;

  Future<Database> getDb()async{
    if(myDb!=null){
      return myDb!;
    }else{
     myDb=await initDb();
     return myDb!;
    }
  }

  Future<Database> initDb()async{
    var root= await getApplicationDocumentsDirectory();
    var mainRoot=join(root.path,'noteDb.Db');
    return  openDatabase(mainRoot,version: 1,onCreate: (db,version){

      db.execute("create table $TABLE_KEY_NOTE ( $TABLE_KEY_ID integer primary key autoincrement , $TABLE_KEY_TITLE text,$TABLE_KEY_DESC text,$TABLE_KEY_TIME text )" ) ;

    });
  }
  void addNote({required NoteModel newNote})async{
    var db=await getDb();
    db.insert('$TABLE_KEY_NOTE',newNote.toMap());
  }
  Future<List<NoteModel>> fecNote()async{
    var db=await getDb();
     var data=await db.query('$TABLE_KEY_NOTE');
    List<NoteModel>mData=[];
    for(Map<String,dynamic> eachData in data){
      var each=NoteModel.fromMap(eachData);
      mData.add(each);
    }
    return mData;
  }
   upDateNote(NoteModel upNotes)async{
    var db=await getDb();
    db.update('$TABLE_KEY_NOTE', upNotes.toMap(),
    where: '$TABLE_KEY_ID=?',whereArgs: ['${upNotes.id}']);

  }
  void deleteNote(int id)async{
    var db=await getDb();
    db.delete('$TABLE_KEY_NOTE',
    where: '$TABLE_KEY_ID=?',
      whereArgs: ['$id']
    );
  }


}