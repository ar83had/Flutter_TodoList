import 'package:flutter/material.dart';

class TodoList extends StatefulWidget{

  const TodoList({super.key});

  State<TodoList> createState()=> _TodoListState();
}

class _TodoListState extends State<TodoList>{

  @override 
  Widget build(BuildContext context){

    return ListView.separated(itemBuilder: itemBuilder, separatorBuilder: separatorBuilder, itemCount: itemCount)
  }
}