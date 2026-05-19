import 'package:bingo_ticketing_system_mobile/pages/home_screen.dart';
import 'package:bingo_ticketing_system_mobile/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';

class ChooseOption extends StatefulWidget {
  const ChooseOption({super.key});

  @override
  State<ChooseOption> createState() => _ChooseOption();
}

class _ChooseOption extends State<ChooseOption> {
  String? selectedValue;
  List<String> options = ['IT Održavanje', 'Elektricari', 'Građevina'];

  void saveHandler(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
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
                    top: 80,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Image.asset(
                        'assets/images/bingo-logo.png',
                        height: 90,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 30,
                    left: 0,
                    right: 0,
                    child: const Center(
                      child: Text(
                        AppStrings.chooseOption,
                        style: TextStyle(
                          color: Appcolors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Appcolors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolors.green2.withValues(),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: selectedValue,
                      decoration: InputDecoration(
                        labelText: AppStrings.chooseOption,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Appcolors.green1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: options.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                    ),

                    const SizedBox(height: 30),

                    GestureDetector(
                      onTap: () => saveHandler(context),
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
                            AppStrings.saveText,
                            style: TextStyle(
                              color: Appcolors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
