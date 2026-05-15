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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Appcolors.green1,
              Appcolors.green2,
              Appcolors.green3,
              Appcolors.green4,
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Center(
          child: Container(
            height: 500,
            width: 500,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Appcolors.lightGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    'lib/assets/images/bingo-logo.png',
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    AppStrings.chooseOption,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Appcolors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: AppStrings.chooseOption,
                    border: OutlineInputBorder(),
                  ),
                  initialValue: selectedValue,
                  hint: const Text(
                    AppStrings.chooseOption,
                    style: TextStyle(color: Appcolors.white),
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
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => saveHandler(context),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Appcolors.green1,
                        ),
                      ),
                      child: Text(
                        AppStrings.saveText,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Appcolors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
