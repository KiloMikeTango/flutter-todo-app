import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String buttonName;
  final Color textcolor;
  VoidCallback onPressed;

  DialogButton({
    super.key,
    required this.buttonName,
    required this.textcolor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      onPressed: onPressed,
      // color: Colors.amber[500],
      child: Text(
        buttonName,
        style: TextStyle(fontSize: 15.0, color: textcolor),
      ),
    );
  }
}
