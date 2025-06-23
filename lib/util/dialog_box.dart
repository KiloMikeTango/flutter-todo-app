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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      title: Text(
        title,
        style: TextStyle(
          color: Color(0xFF4285F4), // Google Blue
          fontWeight: FontWeight.bold,
        ),
      ),

      content:
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      TextField(
        style: TextStyle(color: Colors.black, fontSize: 19.0),
        textCapitalization: TextCapitalization.sentences,
        //  autofocus: true,
        autocorrect: true,
        controller: controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF34A853), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          hintText: "Enter task here",
          hintStyle: TextStyle(color: Colors.grey[500]),
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
