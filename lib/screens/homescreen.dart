import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{

  List<Map<String,dynamic>>? todoData;
  HomeScreen({super.key});


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
    );
  }
}