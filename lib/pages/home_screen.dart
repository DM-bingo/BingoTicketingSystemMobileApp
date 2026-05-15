import 'package:bingo_ticketing_system_mobile/pages/create_new_ticket.dart';
import 'package:bingo_ticketing_system_mobile/pages/settings_page.dart';
import 'package:bingo_ticketing_system_mobile/pages/view_existing_tickets.dart';
import 'package:bingo_ticketing_system_mobile/strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

 void ticketScreen(BuildContext context){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => const CreateNewTicket())
    );
   }

   void viewTicketsScreen(BuildContext context){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => const ViewExistingTickets()));
   }

   void settingScreen(BuildContext context){
    Navigator.push(context,
     MaterialPageRoute(builder: (context)=> const SettingsPage()));
   }


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
                  onPressed: () =>ticketScreen(context),
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
                  
                  onPressed: () =>viewTicketsScreen(context), 
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
                  onPressed: () =>settingScreen(context),
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