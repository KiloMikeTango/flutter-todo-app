import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/colors/homepage_colors.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final String createdAt;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.createdAt,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double font = screenWidth * 0.043;
    double iconSize = screenWidth * 0.06;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.045,
            right: screenWidth * 0.045,
            top: screenWidth * 0.044,
          ),
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
              child: Column(
                children: [
                  Container(
                    // height: 110,
                    padding: EdgeInsets.all(screenWidth* 0.03),
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            //Checkbox
                            Transform.scale(
                              scale: screenWidth* 0.0023,
                              child: Checkbox(
                                value: taskCompleted,
                                onChanged: onChanged,
                                activeColor: Theme.of(context).primaryColor,
                                // activeColor: Colors.green[600],
                              ),
                            ),

                            //User's Task
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                //  textAlign: TextAlign.center,
                                maxLines: 3,
                                taskName,
                                style: TextStyle(
                                  fontSize: font,
                                  decoration:
                                      taskCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                  color:
                                      taskCompleted
                                          ? Colors.grey
                                          : Colors.black87,
                                  fontStyle:
                                      taskCompleted
                                          ? FontStyle.italic
                                          : FontStyle.normal,
                                  fontWeight:
                                      taskCompleted
                                          ? FontWeight.w400
                                          : FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          DateFormat(
                            'MMM d, y – h:mm a',
                          ).format(DateTime.parse(createdAt)),
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
