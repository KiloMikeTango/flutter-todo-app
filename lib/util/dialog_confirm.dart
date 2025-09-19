import 'package:flutter/material.dart';

class DialogConfirm extends StatelessWidget {
  final controller;
  final String title;
  final double titlefsize;
  final Color textcolor;
  final Color oktextcolor;
  final Color canceltextcolor;
  final VoidCallback onOkay;
  final VoidCallback onCancel;

  const DialogConfirm({
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.08,
        vertical: screenHeight * 0.12,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: screenHeight * 0.02,
          horizontal: screenWidth * 0.06,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              size: screenWidth * 0.13, // ~48
              color: Colors.redAccent,
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.05, // ~20
                fontWeight: FontWeight.bold,
                color: textcolor,
              ),
            ),
            SizedBox(height: screenHeight * 0.015),
            Text(
              'Are you sure you want to delete this task? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.037, // ~14
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
               SizedBox(width: screenWidth * 0.05),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: canceltextcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.012,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onOkay,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: oktextcolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.012,
                      ),
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                      color: Colors.white,
                      ),
                    ),
                  ),
                ),
           
              ],
            ),
          SizedBox(height: screenWidth* 0.02,)
          ],
        ),
      ),
    );
  }
}
