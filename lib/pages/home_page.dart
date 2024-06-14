import 'package:flutter/material.dart';
import 'package:flutter_todo/components/dialog_box.dart';
import 'package:flutter_todo/components/todo_tile.dart';
import 'package:flutter_todo/data/database.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox =  Hive.box('myBox');
  final _controller = TextEditingController();
  ToDoDatabase db = ToDoDatabase();
  void checkBoxChanged(bool? value,int index){
    print(value);
    print(index);
    setState(() {
      db.toDoList[index][1]=value;
    });
    db.updateDB();
  }
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);    
      _controller.clear();
    });
    db.updateDB();
    Navigator.of(context).pop();
  }
  void deleteToDo(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDB();
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

  void initState(){

    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
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
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return TodoTile(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1],
            onChanged: (value)=>checkBoxChanged(value, index),
            deleteToDo: (context)=>deleteToDo(index),
          );
        }
      )
    );
  }
}