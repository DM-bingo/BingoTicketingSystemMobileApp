import 'package:bingo_ticketing_system_mobile/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text(AppStrings.demo3, style: TextStyle(fontSize: 20))),
    );
  }
}
