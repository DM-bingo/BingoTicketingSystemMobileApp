import 'package:bingo_ticketing_system_mobile/core/constants/app_colors.dart';
import 'package:bingo_ticketing_system_mobile/core/constants/app_strings.dart';
import 'package:bingo_ticketing_system_mobile/data/models/ticket_model.dart';
import 'package:bingo_ticketing_system_mobile/data/services/view_existing_tickets_service.dart';
import 'package:bingo_ticketing_system_mobile/presentation/pages/details_for_tickets.dart';
import 'package:flutter/material.dart';

class ViewExistingTickets extends StatefulWidget {
  const ViewExistingTickets({super.key});

  @override
  State<ViewExistingTickets> createState() => _ViewExistingTickets();
}

class _ViewExistingTickets extends State<ViewExistingTickets> {
  List<TicketModel> tickets = [];
  bool isLoading = true;
  final _service = ViewExistingTicketsService();

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    try {
      final result = await _service.fetchTickets();
      setState(() {
        tickets = result;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  void openDetails(TicketModel ticket) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailsForTickets(ticket: ticket)),
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
                  color: Appcolors.green2.withValues(alpha: 0.3),
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
                      AppStrings.tickets,
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
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: tickets.length,
                    cacheExtent: 500,
                    itemBuilder: (context, index) {
                      final t = tickets[index];

                      return GestureDetector(
                        onTap: () => openDetails(t),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(18),
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
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Appcolors.green1,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          t.statusLabel,
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
                                          color: Colors.grey.shade200,
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          t.id.toString(),
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
                                      color: const Color(0xFFFFF3D6),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      t.statusLabel,
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              Text(
                                t.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                t.description,
                                style: const TextStyle(color: Colors.black54),
                              ),

                              const SizedBox(height: 15),

                              const Divider(),

                              const SizedBox(height: 10),

                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_outline,
                                    size: 18,
                                    color: Appcolors.green1,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(t.createdByUsername),
                                  const SizedBox(width: 25),
                                  const Icon(
                                    Icons.calendar_today,
                                    size: 18,
                                    color: Appcolors.green1,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(t.createdAt.substring(0, 10)),
                                ],
                              ),

                              const SizedBox(height: 12),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    t.createdAt.substring(0, 10),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => openDetails(t),
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
