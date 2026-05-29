import 'package:bingo_ticketing_system_mobile/data/repositories/auth_repository_impl.dart';
import 'package:bingo_ticketing_system_mobile/data/services/auth_service.dart';
import 'package:bingo_ticketing_system_mobile/data/services/auth_storage.dart';
import 'package:bingo_ticketing_system_mobile/presentation/controllers/auth_controller.dart';
import 'package:bingo_ticketing_system_mobile/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  late final AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = AuthController(
      AuthRepositoryImpl(AuthService()),
      AuthStorage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await controller.logout();

              if(!context.mounted) return;


              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Loginscreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text("Za odjavu samo"),
      ),
    );
  }
}