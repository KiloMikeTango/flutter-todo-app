import 'package:hive_ce_flutter/hive_flutter.dart';

class ToDoDataBase {
  List<Map<String, dynamic>> toDoList = [];

  // Reference the box
  final _taskBox = Hive.box('userTasks');

  void updateData() {
    _taskBox.put("TODOLIST", toDoList);
    print('${toDoList.length} : $toDoList');
  }

  void loadData() {
    final rawList = _taskBox.get("TODOLIST");

    if (rawList != null && rawList is List) {
      try {
        toDoList = List<Map<String, dynamic>>.from(
          rawList.map((e) => Map<String, dynamic>.from(e)),
        );
      } catch (e) {
        print('Error converting toDoList items: $e');
        toDoList = [];
      }
    } else {
      toDoList = [];
    }

    print('${toDoList.length} Data Loaded: $toDoList');
  }
}
