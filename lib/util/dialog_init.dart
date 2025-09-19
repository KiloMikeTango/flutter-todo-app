import 'package:flutter/material.dart';

class InitDialog extends StatelessWidget {
  const InitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false, // 👈 Disable back button
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        insetPadding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.08,  // ~30px on 375px wide screen
          vertical: screenHeight * 0.12,   // ~100px on 800px tall screen
        ),
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            screenWidth * 0.06, // left
            screenHeight * 0.03, // top
            screenWidth * 0.06, // right
            screenHeight * 0.02, // bottom
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Icon(
                  Icons.check_circle_outline,
                  size: screenWidth * 0.15, // responsive icon size
                  color: const Color(0xFF4285F4),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: Text(
                  "Welcome to To-Do App!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.055, // ~22 on 400px wide
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                "Here’s what you can do:",
                style: TextStyle(
                  fontSize: screenWidth * 0.04, // ~16
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                "• Add and manage your daily tasks\n"
                "• Mark tasks as completed\n"
                "• Stay focused and organized",
                style: TextStyle(
                  fontSize: screenWidth * 0.037, // ~15
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF4285F4),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06, // ~20
                      vertical: screenHeight * 0.015, // ~12
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
