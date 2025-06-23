import 'package:hive_ce_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  //reference the box
  final _dataBox = Hive.box('userTasks');

  void createInitialdata() {
    toDoList = [['Make To-Do-App', true]];
  }

  void updateData() {
    _dataBox.put("TODOLIST", toDoList);
  }

  void loadData() {
    toDoList = _dataBox.get("TODOLIST");
  }
}
