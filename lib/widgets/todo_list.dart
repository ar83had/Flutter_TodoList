import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/data/local/db_connect.dart';

class TodoList extends StatefulWidget{

  const TodoList({super.key});

  State<TodoList> createState()=> _TodoListState();
}

class _TodoListState extends State<TodoList>{

  List<Map<String,dynamic>> todoData=[];
  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerDesc = TextEditingController();

  @override
  void initState(){
    super.initState();

    // setTodoData();
    getTodoData();

    return;
  }

  Future<void> getTodoData() async{

    DBHelper db = DBHelper.getInstance;

    todoData = await db.getAllNotes();
    print("Its is todoData : $todoData");
    setState(() {});
  }

  Future<void> setTodoData({required String title, required String desc}) async{

    DBHelper db = DBHelper.getInstance;

    bool rowAdded = await db.addNotes(title: title, desc: desc);

    if(rowAdded){
      print("Data added");
    }else{
      print("Data Does not added!");
    }

    return;
  }

  @override 
  Widget build(BuildContext context){

    return todoData.length<=0?Center(
      child: Text("No Task yet"),
    ):Padding(
      padding: EdgeInsetsGeometry.only(bottom:45,top:20,left:5,right:5),
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (_,index){
                return ListTile(
                  title: Text(todoData[index][DBHelper.COLUMN_NOTES_TITLE]),
                  subtitle: Text(todoData[index][DBHelper.COLUMN_NOTES_DESC]),
                );
              }, 
              separatorBuilder: (context,index){
                return Divider();
              }, 
              itemCount: todoData.length
            ),
          ),
          FloatingActionButton(
            child:Icon(Icons.add),
            onPressed: (){
              showModalBottomSheet(
                context: context, 
                builder: (context){
                  return Container(
                    height: 400,
                    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          "Add Notes",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30,),
                        TextField(
                          controller: controllerTitle,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Title"),
                            hintText: "Enter Title here"
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller: controllerDesc,
                          maxLines: 3,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Description"),
                            hintText: "Enter Description here",
                          ),
                        ),
                        SizedBox(height: 20,),
                        SizedBox(
                          width: 200,
                          child: OutlinedButton(
                            onPressed: (){
                                String? title = controllerTitle.value.text;
                                String? desc = controllerDesc.value.text;

                                if(!title.isEmpty && !desc.isEmpty){
                                  setTodoData(title: title, desc: desc);
                                  getTodoData();
                                  Navigator.pop(context);
                                  controllerTitle.clear();
                                  controllerDesc.clear();
                                }
                                else{
                                  debugPrint("All Field is required!");
                                }
                            }, 
                            child: Text("Add")
                          ),
                        )
                      ],
                    ),
                  );
                }
              );
            }
          )
        ],
      ),
    );
  }
}