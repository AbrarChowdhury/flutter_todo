import 'package:flutter/material.dart';
import 'package:flutter_todo/components/dialog_box.dart';
import 'package:flutter_todo/components/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List toDoList = [];
  void checkBoxChanged(bool? value,int index){
    print(value);
    print(index);
    setState(() {
      toDoList[index][1]=value;
    });
  }
  void saveNewTask(){
    setState(() {
      toDoList.add([_controller.text, false]);    
    });
    Navigator.of(context).pop();
  }

  void createNewTask(){
    showDialog(
      context: context, 
      builder: (context){
        return DialogBox(
          controller:_controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      } 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title:Text("masti"),
        elevation: 0,
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index){
          return TodoTile(
            taskName: toDoList[index][0], 
            taskCompleted: toDoList[index][1],
            onChanged: (value)=>checkBoxChanged(value, index),
          );
        }
      )
    );
  }
}