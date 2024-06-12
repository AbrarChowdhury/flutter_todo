import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => TodoPageState();
}

class TodoPageState extends State<TodoPage> {
  TextEditingController myController = TextEditingController();
  String message = "";
  void onPressed(){
    setState(() {
      message="hey "+ myController.text;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message),
                TextField(
                  controller: myController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Type your name",
                    ),
                ),
                ElevatedButton(onPressed: onPressed, child: Text("Tap"))
              ],
            ),
          )
        ),
    );
  }
}