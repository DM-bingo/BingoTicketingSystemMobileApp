import 'package:bingo_ticketing_system_mobile/presentation/pages/create_new_ticket.dart';
import 'package:bingo_ticketing_system_mobile/presentation/pages/settings_page.dart';
import 'package:bingo_ticketing_system_mobile/presentation/pages/ticket_maps_screen.dart';
import 'package:bingo_ticketing_system_mobile/presentation/pages/view_existing_tickets.dart';
import 'package:bingo_ticketing_system_mobile/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:bingo_ticketing_system_mobile/core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  void ticketScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateNewTicket()),
    );
  }

  void viewTicketsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ViewExistingTickets()),
    );
  }

  void settingScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }

  void ticketMapScreen(BuildContext context){
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => const TicketsMapScreen())
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 280,
            width: double.infinity,
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
                  top: 70,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(
                      'assets/images/bingo-logo.png',
                      height: 90,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      AppStrings.dashboard,
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

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => ticketScreen(context),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Appcolors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.green2.withValues(),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.add_circle,
                            color: Appcolors.green1,
                            size: 40,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              AppStrings.createTicket,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 18),
                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () => viewTicketsScreen(context),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Appcolors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.green2.withValues(),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.list_alt,
                            color: Appcolors.green1,
                            size: 40,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              AppStrings.viewExistingTickets,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 18),
                        ],
                      ),
                    ),
                  ),

                

                  GestureDetector(
                    onTap: () => ticketMapScreen(context),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                       margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Appcolors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.green2.withValues(),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          )
                        ]
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.location_city_rounded,
                            color: Appcolors.green1,
                            size: 40,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              AppStrings.googleMaps,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 18,)
                        ],
                      ),
                    ),
                  ),

                    GestureDetector(
                    onTap: () => settingScreen(context),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Appcolors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.green2.withValues(),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.settings,
                            color: Appcolors.green1,
                            size: 40,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              AppStrings.settings,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
