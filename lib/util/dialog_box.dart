import 'package:flutter/material.dart';
import 'package:to_do_app/util/dialog_buttons.dart';

class DialogBox extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();
  final String title;
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.title,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF4285F4),
          fontWeight: FontWeight.bold,
          fontSize: screenWidth * 0.05,
        ),
      ),

      content: SizedBox(
        width: screenWidth * 0.8, // 80% of screen width
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: TextStyle(
                color: Colors.black,
                fontSize: screenWidth * 0.04,
              ),
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              controller: controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF34A853), width: 1.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: "Enter task here",
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ],
        ),
      ),

      actions: [
        DialogButton(
          buttonName: "CANCEL",
          textcolor: Colors.grey[700]!,
          onPressed: onCancel,
        ),
        SizedBox(width: 2),
        DialogButton(
          buttonName: "SAVE",
          textcolor: Color(0xFF34A853),
          onPressed: onSave,
        ),
      ],
    );
  }
}
