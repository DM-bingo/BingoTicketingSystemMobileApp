import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';
import 'package:bingo_ticketing_system_mobile/pages/details_for_tickets.dart';
import 'package:flutter/material.dart';

class ViewExistingTickets extends StatefulWidget {
  const ViewExistingTickets({super.key});

  @override
  State<ViewExistingTickets> createState() => _ViewExistingTickets();
}

class _ViewExistingTickets extends State<ViewExistingTickets> {
  void detailScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DetailsForTickets()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 260,
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
                      height: 80,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 25,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Tickets",
                      style: TextStyle(
                        color: Appcolors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                GestureDetector(
                  onTap: () => detailScreen(context),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Appcolors.green2.withValues(),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Appcolors.green1,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'IT ODRŽAVANJE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    '028',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF3D6),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Na čekanju',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          'Problem sa printerom',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Printer ne štampa u boji, potrebna popravka',
                          style: TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 15),

                        const Divider(),

                        const SizedBox(height: 10),

                        Row(
                          children: const [
                            Icon(
                              Icons.person_outline,
                              size: 18,
                              color: Appcolors.green1,
                            ),
                            SizedBox(width: 6),
                            Text('Mirza Šabanović'),
                            SizedBox(width: 25),
                            Icon(
                              Icons.calendar_today,
                              size: 18,
                              color: Appcolors.green1,
                            ),
                            SizedBox(width: 6),
                            Text('12.06.2026'),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '07.06.2026',
                              style: TextStyle(color: Colors.black54),
                            ),

                            GestureDetector(
                              onTap: () => detailScreen(context),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Appcolors.green1,
                                      Appcolors.green3,
                                    ],
                                  ),
                                ),
                                child: const Text(
                                  'Detalji',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
