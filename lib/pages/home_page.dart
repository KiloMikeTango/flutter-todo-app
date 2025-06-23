import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/dialog_confirm.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //refference the hive box
  final _dataBox = Hive.box('userTasks');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_dataBox.get("TODOLIST") == null) {
      db.createInitialdata();
    } else {
      db.loadData();
    }
    super.initState();
  }

  //text input controller
  final _controller = TextEditingController();
  //scroll controller
  final ScrollController _scrollController = ScrollController();

  //When checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateData();
  }

  //Check if task is empty
  void checkTask() {
    String userText = _controller.text.trim(); // trim once and reuse

    if (userText.isEmpty) {
      Navigator.of(context).pop(); // Close the dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          showCloseIcon: true,
          backgroundColor: Colors.red,
          content: Text(
            "Task can't be empty!",
            style: TextStyle(fontSize: 17.0),
          ),
        ),
      );
    } else {
      setState(() {
        db.toDoList.add([
          userText[0].toUpperCase() + userText.substring(1),
          false,
        ]);
      });
      _controller.clear();
      Navigator.of(context).pop();

      // Scroll after delay
      Future.delayed(Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });

      db.updateData(); // Only update when a task is added
    }
  }

  //Save new task
  void saveNewTask() {
    checkTask();

    db.updateData();
  }

  //Create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          title: 'Add New Task',
          onCancel: Navigator.of(context).pop,
          onSave: saveNewTask,
        );
      },
    );
  }

  //Delete task
  deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF4285F4),
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "TO-DO-TILES",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),

      //floating add note button
      floatingActionButton: 
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFF34A853), Color(0xFF0F9D58)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: IconButton(
          icon: Icon(Icons.add, color: Colors.white, size: 30),
          onPressed: createNewTask,
        ),
      ),

      body: SafeArea(
        child: ListView.builder(
          controller: _scrollController,
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return DialogConfirm(
                      titlefsize: 18.0,
                      textcolor: Colors.red,
                      oktextcolor: Color(0xFFE53935),
                      canceltextcolor: Color(0xFF333333),
                      controller: _controller,
                      title: 'Delete This Task?',
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                      onOkay: () {
                        Navigator.of(context).pop();
                        deleteTask(index);
                      },
                    );
                  },
                );
              },
            );
          },
          padding: EdgeInsets.only(bottom: 113),
        ),
      ),
    );
  }
}
