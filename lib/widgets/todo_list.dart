import 'package:flutter/material.dart';
import 'package:todolist/data/local/db_connect.dart';

class TodoList extends StatefulWidget{

  const TodoList({super.key});

  State<TodoList> createState()=> _TodoListState();
}

class _TodoListState extends State<TodoList>{

  late List<Map<String,dynamic>> todoData;

  @override
  void initState(){
    super.initState();

    setTodoData();
    getTodoData();

    return;
  }

  Future<void> getTodoData() async{
    DBHelper db = DBHelper.getInstance;

    todoData = await db.getAllNotes();
    print("Its is todoData : $todoData");
  }

  Future<void> setTodoData() async{

    DBHelper db = DBHelper.getInstance;

    bool rowAdded = await db.addNotes(title: "Test Title", desc: "Test Description");

    if(rowAdded){
      print("Data added");
    }else{
      print("Data Does not added!");
    }

    return;
  }

  @override 
  Widget build(BuildContext context){

    return Container(
      child: Text("Arshad"),
    );
  }
}