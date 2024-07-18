import 'package:bloc_provider/State.dart';
import 'package:bloc_provider/page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dtFor=DateFormat.Hm();

  @override
  void initState() {
    super.initState();
    context.read<DbList>().getNotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data'),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder<DbList,ListCubit>(
        builder: (_,State){
          return State.mDataB.isNotEmpty?
            ListView.builder(
            itemCount: State.mDataB.length,
              itemBuilder: (_,index){
            return ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage2(isUpdate: true,myModel: State.mDataB[index]),));
              },
              title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(State.mDataB[index].title),
                  Text(dtFor.format(DateTime.fromMillisecondsSinceEpoch(int.parse(State.mDataB[index].createAt)))),
                ],
              ),
              subtitle: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(State.mDataB[index].desc),
                  InkWell(
                    onTap: (){
                     context.read<DbList>().delete(State.mDataB[index].id);
                    },
                      child: Icon(Icons.delete))
                ],
              ),

            );
          }):
              Center(
                child: Lottie.asset('assets/lottie/no data.json',height: 350,width: 350),
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage2(),));
        },child: Icon(Icons.add),
      ),
    );
  }
}
