import 'package:bingo_ticketing_system_mobile/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';
import 'package:bingo_ticketing_system_mobile/strings/app_strings.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _passwordController = TextEditingController();

  void checkPassword(BuildContext context, password) {
    if (password == 'admin') {
      Navigator.push(
        context,
        MaterialPageRoute<void>(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.wrongPassword)));
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 320,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Appcolors.green1, Appcolors.green2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: const Center(
                        child: Text(
                          AppStrings.loginText,
                          style: TextStyle(
                            color: Appcolors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 70,
                    left: 0,
                    right: 0,
                    child: FadeInUp(
                      duration: const Duration(milliseconds: 1000),
                      child: Center(
                        child: Image.asset(
                          'assets/images/bingo-logo.png',
                          height: 100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Appcolors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Appcolors.green2),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.green2.withValues(),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: AppStrings.enterPassword,
                          prefixIcon: Icon(Icons.lock, color: Appcolors.grey),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  FadeInUp(
                    duration: const Duration(milliseconds: 1700),
                    child: GestureDetector(
                      onTap: () =>
                          checkPassword(context, _passwordController.text),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Appcolors.green1, Appcolors.green3],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            AppStrings.loginText,
                            style: TextStyle(
                              color: Appcolors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
