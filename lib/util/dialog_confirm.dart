import 'package:flutter/material.dart';
import 'package:to_do_app/util/dialog_buttons.dart';

class DialogConfirm extends StatelessWidget {
  final controller;
  final String title;
  final double titlefsize;
  final Color textcolor;
  final Color oktextcolor;
  final Color canceltextcolor;
  VoidCallback onOkay;
  VoidCallback onCancel;

  DialogConfirm({
    super.key,
    required this.controller,
    required this.title,
    required this.titlefsize,
    required this.textcolor,
    required this.oktextcolor,
    required this.canceltextcolor,
    required this.onOkay,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        title,
        style: TextStyle(
          color: textcolor,
          fontSize: titlefsize,
          fontWeight: FontWeight.bold,
        ),
      ),
      contentPadding: EdgeInsets.all(20),
      actions: [
        DialogButton(
          buttonName: 'CANCEL',
          textcolor: canceltextcolor,
          onPressed: onCancel,
        ),
        DialogButton(
          buttonName: 'DELETE',
          textcolor: oktextcolor,
          onPressed: onOkay,
        ),
      ],
    );
  }
}
