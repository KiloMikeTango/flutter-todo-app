import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/dialog_confirm.dart';
import 'package:to_do_app/util/dialog_init.dart';
import 'package:to_do_app/util/drawer_homepage.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final _dataBox = Hive.box('userTasks');

  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    checkFirstLaunch();
    db.loadData();

    super.initState();
  }

  //Check if it is the first time opens the app

  Future<void> checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime && mounted) {
      // Perform actions for first launch
      await showDialog(
        context: context,
        builder: (context) {
          return InitDialog();
        },
      );
      await prefs.setBool('isFirstTime', false);
    } else {
      // Perform actions for subsequent launches
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            showCloseIcon: true,
            backgroundColor: Colors.blue,
            content: Text("Welcome back!", style: TextStyle(fontSize: 16.0)),
          ),
        );
      }
    }
  }

  //text input controller
  final _controller = TextEditingController();
  //scroll controller
  final ScrollController _scrollController = ScrollController();

  //When checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index]['completed'] = !db.toDoList[index]['completed'];
    });
    db.updateData();
    if (db.toDoList[index]['completed']) {
      deleteCheckedTask(index);
    } else {
      db.toDoList[index]['completed'] == false;
      db.updateData();
    }
  }

  //Delete task in a minute afer checkbox is checked
  Future deleteCheckedTask(int index) async {
    Future.delayed(Duration(minutes: 1), () => deleteTask(index));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        backgroundColor: Colors.green,
        content: Text(
          "Task will be deleted in a minute!",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
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
        db.toDoList.add({
          "time": DateTime.now(),
          "task": userText[0].toUpperCase() + userText.substring(1),
          "completed": false,
        });
        Navigator.of(context).pop();
        _controller.clear();
      });

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
      barrierDismissible: false,
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final double font = screenWidth * 0.045;

    final currentWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      // TO-DO-TILES app bar
      drawer: MyDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF4285F4),
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.white),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(
                  Icons.menu,
                  size: screenWidth * 0.073,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
        title: Text(
          "TO-DO-TILES",
          style: TextStyle(
            fontSize: screenWidth * 0.055,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ),

      //floating add  button
      floatingActionButton: Container(
        width: screenWidth * 0.13,
        height: screenWidth * 0.13,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Color(0xFF34A853), Color(0xFF0F9D58)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: IconButton(
          icon: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.06),
          onPressed: createNewTask,
        ),
      ),

      body:
          db.toDoList.isNotEmpty
              ? SafeArea(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: db.toDoList.length,
                  itemBuilder: (context, index) {
                    return ToDoTile(
                      //Date and Time
                      createdAt: db.toDoList[index]['time'].toString(),
                      //Task Name
                      taskName: db.toDoList[index]['task'],
                      //Task completed or not
                      taskCompleted: db.toDoList[index]['completed'],
                      //checkbox
                      onChanged: (value) => checkBoxChanged(value, index),
                      deleteFunction: (context) {
                        showDialog(
                          barrierDismissible: false,
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
              )
              : Center(
                child: Text(
                  //currentWidth.toString(),
                  'No tasks yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
    );
  }
}
