import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';
import 'package:bingo_ticketing_system_mobile/pages/choose_option.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();

  }

  class _LoginscreenState extends State<Loginscreen>{
    final TextEditingController _passwordController = TextEditingController();

     void checkPassword(BuildContext context, password) {
    if (password == 'admin') {
      Navigator.push(context, 
      MaterialPageRoute<void>(builder: (context) => const ChooseOption()));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pogrešna šifra'))
      );
    }
  }

  @override
  void dispose(){
    _passwordController.dispose();
    super.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'lib/assets/images/bingo-logo.png',
                  height: 100,
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 20),

                const Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Appcolors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),

                const SizedBox(height: 40),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(color: Appcolors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Appcolors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Appcolors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Appcolors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.lock, color: Appcolors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () => checkPassword(context,_passwordController.text),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Appcolors.green1),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Appcolors.white,
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
