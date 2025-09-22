import 'package:flutter/material.dart';
import 'package:to_do_app/util/toggle_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
       centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text('Settings'),
      ),
    body: ToggleTheme()
    );
  }
}
