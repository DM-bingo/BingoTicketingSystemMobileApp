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

  void ticketMapScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TicketsMapScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Appcolors.green1, Appcolors.green2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
              boxShadow: [
                BoxShadow(
                  color: Appcolors.green2.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
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
                      height: 95,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 35,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      AppStrings.dashboard,
                      style: const TextStyle(
                        color: Appcolors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              children: [
                _buildDashboardCard(
                  context: context,
                  icon: Icons.add_circle_outline_rounded,
                  title: AppStrings.createTicket,
                  onTap: () => ticketScreen(context),
                ),
                _buildDashboardCard(
                  context: context,
                  icon: Icons.list_alt_rounded,
                  title: AppStrings.viewExistingTickets,
                  onTap: () => viewTicketsScreen(context),
                ),
                _buildDashboardCard(
                  context: context,
                  icon: Icons.map_outlined,
                  title: AppStrings.googleMaps,
                  onTap: () => ticketMapScreen(context),
                ),
                _buildDashboardCard(
                  context: context,
                  icon: Icons.settings_outlined,
                  title: AppStrings.settings,
                  onTap: () => settingScreen(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Appcolors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Appcolors.green1.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Appcolors.green1, size: 28),
                ),
                title: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.grey.shade400,
                  size: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
