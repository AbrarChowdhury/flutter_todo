import 'package:hive_flutter/adapters.dart';

class ToDoDatabase {
  List toDoList=[];
  final _myBox = Hive.box("mybox");

  void createInitialData(){
    toDoList = [
      ["pray fajr",false],
      ["Do leetcode",false],
    ];
  }

  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  void updateDB(){
    _myBox.put("TODOLIST", toDoList);
  }
}