import 'package:bingo_ticketing_system_mobile/core/constants/app_colors.dart';
import 'package:bingo_ticketing_system_mobile/data/models/ticket_model.dart';
import 'package:flutter/material.dart';

class DetailsForTickets extends StatefulWidget {
  final TicketModel ticket;

  const DetailsForTickets({super.key, required this.ticket});

  @override
  State<DetailsForTickets> createState() => _DetailsForTickets();
}

class _DetailsForTickets extends State<DetailsForTickets> {
  @override
  Widget build(BuildContext context) {
    final ticket = widget.ticket;
    final images = ticket.images;

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
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              ticket.categoryName,
                              style: const TextStyle(
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
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              ticket.id.toString(),
                              style: const TextStyle(fontSize: 12),
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
                          color: const Color(0xFFFFE5B4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          ticket.status,
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    ticket.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    ticket.description,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.person_outline,
                          size: 18, color: Colors.green),
                      const SizedBox(width: 6),
                      const Text('Odgovorna osoba: '),
                      Text(
                        ticket.assignedToUsername,
                        style:
                            const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.person,
                          size: 18, color: Colors.green),
                      const SizedBox(width: 6),
                      const Text('Kreirao: '),
                      Text(
                        ticket.createdByUsername,
                        style:
                            const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Kreirano: ${ticket.createdAt}',
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),
                  if (images.isNotEmpty) ...[
                    const Text(
                      'Slike',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: images.length,
                        itemBuilder: (_, i) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "http://172.23.207.83:5000${images[i].photoUrl}",
                                width: 120,
                                height: 120,
                                cacheWidth: 300,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Zatvori ticket'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}