import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';
import 'package:flutter/material.dart';

class DetailsForTickets extends StatefulWidget {
  const DetailsForTickets({super.key});

  @override
  State<DetailsForTickets> createState() => _DetailsForTickets();
}

class _DetailsForTickets extends State<DetailsForTickets> {
  final List<String> images = [
    'https://cdn.phototourl.com/free/2026-05-18-84885704-d1e2-43be-ad4a-42d7a7e6d828.png',
    'https://cdn.phototourl.com/free/2026-05-18-84885704-d1e2-43be-ad4a-42d7a7e6d828.png',
    'https://cdn.phototourl.com/free/2026-05-18-84885704-d1e2-43be-ad4a-42d7a7e6d828.png',
  ];

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
          child: SingleChildScrollView(
            child: Container(
              width: 700,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Appcolors.white,
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
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Na čekanju',
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Problem sa printerom',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Printer ne štampa u boji, potrebna popravka. Potrebno je provjeriti tonere i izvršiti servis uređaja.',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 15),
                  Row(
                    children: const [
                      Icon(Icons.person_outline,
                          size: 18, color: Colors.green),
                      SizedBox(width: 6),
                      Text('Odgovorna osoba: '),
                      Text(
                        'Mirza Šabanović',
                        style:
                            TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 30),
                      Icon(Icons.calendar_today,
                          size: 18, color: Colors.green),
                      SizedBox(width: 6),
                      Text('Rok: '),
                      Text(
                        '12.06.2026',
                        style:
                            TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Kreirano: 07.05.2026',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Slike',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(right: 10),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10),
                            child: Image.network(
                              images[index],
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Zatvori ticket'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}