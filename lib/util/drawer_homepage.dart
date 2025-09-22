import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/pages/settings.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double font = screenWidth * 0.045;
    double icon = screenWidth * 0.06;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
              screenWidth * 0.05, // left = 5% of screen width
              screenWidth *
                  0.15, // top = 15% of screen width (roughly same as 60px on 400px screen)
              screenWidth * 0.05, // right = 5% of screen width
              screenWidth * 0.05, // bottom = 5% of screen width
            ),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'To-Do App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Stay focused & organized',
                  style: TextStyle(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.9),
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          //Contact
          ListTile(
            leading: Icon(
              Icons.person_outline,
              size: icon,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Contact',
              style: TextStyle(
                fontSize: font,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onTap: () {
              Fluttertoast.showToast(
                backgroundColor: Colors.grey[700],
                msg: "Navigating...",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.white,
                fontSize: font,
              );
              openUrl();
              Navigator.pop(context);
            },
          ),

          //Settings
          ListTile(
            leading: Icon(
              Icons.settings_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text(
              'Settings',
              style: TextStyle(
                fontSize: font,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          Spacer(),

          //App version
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 20),
            child: Text(
              'v1.1.0',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: screenWidth * 0.04,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void openUrl() async {
  final Uri url = Uri.parse('https://t.me/Kilo532');
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.inAppBrowserView);
  } else {
    throw 'Could not launch $url';
  }
}
