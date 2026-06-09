import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TicketsMapScreen extends StatefulWidget {
  const TicketsMapScreen({super.key});

  @override
  State<TicketsMapScreen> createState() => _TicketsMapScreenState();
}

class _TicketsMapScreenState extends State<TicketsMapScreen> {
  final Set<Marker> markers = {
    Marker(
      markerId: const MarkerId("1"),
      position: const LatLng(44.537, 18.676),
      infoWindow: const InfoWindow(
        title: "Printer ne radi",
        snippet: "IT održavanje",
      ),
    ),
    Marker(
      markerId: const MarkerId("2"),
      position: const LatLng(44.530, 18.700),
      infoWindow: const InfoWindow(title: "Kasa problem", snippet: "Cash desk"),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mapa tiketa")),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(44.537, 18.676),
          zoom: 12,
        ),
        markers: markers,
      ),
    );
  }
}
