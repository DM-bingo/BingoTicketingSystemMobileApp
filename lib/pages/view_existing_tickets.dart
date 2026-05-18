import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';
import 'package:bingo_ticketing_system_mobile/strings/app_strings.dart';
import 'package:flutter/material.dart';

class ViewExistingTickets extends StatefulWidget {
  const ViewExistingTickets({super.key});

  @override
  State<ViewExistingTickets> createState() =>
      _ViewExistingTickets();
}

class _ViewExistingTickets extends State<ViewExistingTickets> {
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
            colors: [
              Appcolors.green1,
              Appcolors.green2,
              Appcolors.green3,
              Appcolors.green4,
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: 700,
            height: 300,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F4F4),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'IT ODRŽAVANJE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius:
                                BorderRadius.circular(20),
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
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE5B4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Na čekanju',
                        style: TextStyle(
                            color: Colors.orange, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  'Problem sa printerom',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
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
                    Icon(Icons.person_outline,
                        size: 18, color: Colors.green),
                    SizedBox(width: 6),
                    Text('Odgovorna osoba: '),
                    Text(
                      'Mirza Šabanović',
                      style: TextStyle(
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 30),
                    Icon(Icons.calendar_today,
                        size: 18, color: Colors.green),
                    SizedBox(width: 6),
                    Text('Rok: '),
                    Text(
                      '12.06.2026',
                      style: TextStyle(
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Kreirano: 07.06.2026',
                      style:
                          TextStyle(color: Colors.black54),
                    ),                          
                  ],
                ),
                ElevatedButton(onPressed: () =>{}, 
                    child: Text('Detalji'),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Appcolors.green1,
                      )
                    ) ,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}