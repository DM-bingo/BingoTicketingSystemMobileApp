import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        title: Text('LoginScreen', style: TextStyle(color: Appcolors.white)),
        backgroundColor: Appcolors.lightGreen,
      ),
      body: Center(
        child:  Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
            color: Appcolors.lightGreen,
            borderRadius: BorderRadius.circular(10)
          ),
         child: const Text('Login', 
         textAlign: TextAlign.center , 
         style: TextStyle(
          color: Appcolors.white,
          fontWeight: FontWeight.bold ,
          fontSize: 20
         ),
         ), 
        ),
      )
    );
  }
}
