import 'package:bingo_ticketing_system_mobile/strings/app_strings.dart';
import 'package:flutter/material.dart';

class ViewExistingTickets extends StatefulWidget {
  const ViewExistingTickets({super.key});

  @override
  State<ViewExistingTickets> createState() => _ViewExistingTickets();
}

class _ViewExistingTickets extends State<ViewExistingTickets> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          AppStrings.demo2,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
