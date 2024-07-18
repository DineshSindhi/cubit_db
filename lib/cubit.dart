import 'package:bloc_provider/Database.dart';
import 'package:bloc_provider/Model.dart';
import 'package:bloc_provider/State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DbList extends Cubit<ListCubit>{
  MyAppDb db;
  DbList({required this.db}):super(ListCubit(mDataB: []));

  void addNote(NoteModel newNote)async{
    db.addNote(newNote: newNote);
    var myData=state.mDataB;
    myData=await db.fecNote();
       
    emit(ListCubit(mDataB: myData));
  }
  void getNotes()async{
    var myData=state.mDataB;
    myData=await db.fecNote();
    emit(ListCubit(mDataB: myData));
  }
  void upNote(NoteModel upNote)async{
    db.upDateNote(upNote);
    var myData=state.mDataB;
    myData=await db.fecNote();

    emit(ListCubit(mDataB: myData));
  }
  void delete(int id)async{
    db.deleteNote(id);
    var myData=state.mDataB;
    myData=await db.fecNote();

    emit(ListCubit(mDataB: myData));
  }

}
