import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/colors/homepage_colors.dart';

class ToDoTile extends StatelessWidget {
  
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  
  
  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24),
          child: Material(
            elevation: 1.5,
            borderRadius: BorderRadius.circular(12),
            child: Slidable(
              endActionPane: ActionPane(
                motion: StretchMotion(),
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),

                    onPressed: deleteFunction,
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(19),
                decoration: BoxDecoration(
                  color: listTileColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    //Checkbox
                    Transform.scale(
                      scale: 1.1,
                      child: Checkbox(
                        value: taskCompleted,
                        onChanged: onChanged,
                        activeColor: Theme.of(context).primaryColor,
                        // activeColor: Colors.green[600],
                      ),
                    ),

                    //User's Tasks
                    Text(
                      taskName,
                      style: TextStyle(
                        fontSize: 17.2,
                        // decoration:
                        //     taskCompleted
                        //         ? TextDecoration.lineThrough
                        //         : TextDecoration.none,
                        // color:
                        //     taskCompleted ? Colors.green[900] : Colors.black87,
                        decoration:
                            taskCompleted ? TextDecoration.lineThrough : null,
                        color: taskCompleted ? Colors.grey : Colors.black87,
                        fontStyle:
                            taskCompleted ? FontStyle.italic : FontStyle.normal,
                        fontWeight:
                            taskCompleted ? FontWeight.w400 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
