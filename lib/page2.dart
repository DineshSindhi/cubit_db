import 'package:bloc_provider/Model.dart';
import 'package:bloc_provider/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage2 extends StatelessWidget {
  bool isUpdate;
  NoteModel? myModel;

  HomePage2({this.isUpdate = false,this.myModel});

  var titleController=TextEditingController();

  var descController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(myModel!=null){
      titleController.text=myModel!.title;
      descController.text=myModel!.desc;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding:  EdgeInsets.only( top: 20,left: 15,right: 15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: titleController,
              decoration: InputDecoration(
                  label: Text('Enter Title'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  )
              ),),
            SizedBox(height: 15,),
            TextField(controller: descController,
              decoration: InputDecoration(
                  label: Text('Enter Subtitle'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
              ),),
            SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  if(isUpdate){
                    context.read<DbList>().upNote(NoteModel( title: titleController.text,
                      desc: descController.text,createAt: myModel!.createAt,id: myModel!.id));
                    Navigator.pop(context);
                  }else{
                  context.read<DbList>().addNote(NoteModel(
                      title: titleController.text,
                      desc: descController.text,
                      createAt: DateTime.now().millisecondsSinceEpoch.toString()));
                  Navigator.pop(context);}
                }, child: Text(isUpdate?'Update Note':'Add Note',style: TextStyle(fontSize: 25),)),
                ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Cancel',style: TextStyle(fontSize: 25),)),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
//if(isUpdate){
//                     // var UpdatNote=
//                     context.read<MyProvider>().upDate(StModel(title: titleController.text
//                         , desc: descController.text, createAt: myModel!.createAt,id: myModel!.id));
//                     Navigator.pop(context);
//                   }
//                   else{
//                     context.read<MyProvider>().addNotes(StModel(title: titleController.text,
//                         desc: descController.text,
//                         createAt: DateTime.now().millisecondsSinceEpoch.toString()));
//  Navigator.pop(context);}