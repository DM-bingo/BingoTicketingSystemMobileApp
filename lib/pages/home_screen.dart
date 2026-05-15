import 'package:bingo_ticketing_system_mobile/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8,1),
            colors: <Color>[
                Appcolors.green1,
                Appcolors.green2,
                Appcolors.green3,
                Appcolors.green4,
            ],
            tileMode: TileMode.mirror
          )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: () =>{},
                 child: Text(AppStrings.createTicket, )        
                  ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 300,
                height: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  
                  onPressed: () =>{}, 
                child: Text(AppStrings.viewExistingTickets)),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 300,
                height: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  onPressed: () =>{},
                  child: Text(AppStrings.settingsText),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
} 