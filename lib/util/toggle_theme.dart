import 'package:flutter/material.dart';
import 'package:to_do_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class ToggleTheme extends StatefulWidget {
  const ToggleTheme({super.key});

  @override
  State<ToggleTheme> createState() => _ToggleThemeState();
}

class _ToggleThemeState extends State<ToggleTheme> {
  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    return Padding(
      padding: const EdgeInsets.all(7.0),
      child: ListTile(
        leading: Text('DarkMode', style: TextStyle(fontSize: 20)),
        trailing: Switch(
          inactiveTrackColor: Theme.of(context).colorScheme.primary,
          inactiveThumbColor: Colors.grey,
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
              print(isSwitched);
            });
          },
        ),
      ),
    );
  }
}
