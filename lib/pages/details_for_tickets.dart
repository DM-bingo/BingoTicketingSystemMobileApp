import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';
import 'package:flutter/material.dart';

class DetailsForTickets extends StatefulWidget {
  const DetailsForTickets({super.key});

  @override
  State<DetailsForTickets> createState() => _DetailsForTickets();
}

class _DetailsForTickets extends State<DetailsForTickets> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Container(
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
              Appcolors.green4
            ],
            tileMode: TileMode.mirror
            
          )
        ),
        child: Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              color: Appcolors.white,
              
            ),
            child: Center(child: Text('Ovde ce biti detalji')),
          ),
        ),
      )
    );
  }
}