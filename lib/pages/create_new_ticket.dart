import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bingo_ticketing_system_mobile/strings/app_strings.dart';

class CreateNewTicket extends StatefulWidget {
  const CreateNewTicket({super.key});

  @override
  State<CreateNewTicket> createState() => _CreateNewTicket();
}

class _CreateNewTicket extends State<CreateNewTicket> {
  String? selectedValue;
  List<String> options = ['IT Održavanje', 'Eleketricari', 'Građevina'];

  String? selectedValue1;
  List<String> options1 = [
    'Objekat Šicki 22',
    'Objekat BCC Tuzla 211',
    'Objekat Sarajevo 206',
  ];

  String? priority;
  List<String> priorityValues = ['Nizak', 'Srednji', 'Visok'];

  String? optionsValue;
  List<String> listOfOptions = ['SERVIS', 'NABAVA'];

  String? serviceOptions;
  List<String> listOfServiceOptions = [
    'Elektroinstalacije',
    'Mašinske Instalacije',
    'Vodovod i Kanalizacija',
    'Frigoinstalacije',
    'Vrata i Prozori',
    'Građevinsko-Zanatski Poslovi',
    'Sigurnosni Sistemi',
    'IT Oprema',
    'Proizvodne Linije',
    'Reklame i Označavanje',
    'Tehnološka Oprema',
  ];

  String? electroOptions;
  List<String> listOfElectroOptions = [
    'Elektroinstalacije-Rasvjeta',
    'Agregati',
    'Utičnice',
    'Ups',
    'Trafo Stanica',
    'Razglas',
  ];

  String? machineOptions;
  List<String> listOfMachineOptions = [
    'Grijanje',
    'Hlađenje',
    'Ventilacija',
    'Sprinkler',
    'Kuhinjske Nape',
    'Liftovi, Pokretne Stepenice, Travelator',
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
            colors: <Color>[
              Appcolors.green1,
              Appcolors.green2,
              Appcolors.green3,
              Appcolors.green4,
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: Center(
          child: Container(
            width: 600,
            height: 700,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Appcolors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: AppStrings.requestType,
                    border: OutlineInputBorder(),
                  ),
                  initialValue: options[0],
                  hint: const Text(
                    AppStrings.requestType,
                    style: TextStyle(color: Appcolors.white),
                  ),
                  items: options.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  },
                ),
                const SizedBox(height: 40),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: AppStrings.objectText,
                    border: OutlineInputBorder(),
                  ),
                  initialValue: options1[0],
                  hint: const Text(
                    AppStrings.objectText,
                    style: TextStyle(color: Appcolors.white),
                  ),
                  items: options1.map((String value1) {
                    return DropdownMenuItem<String>(
                      value: value1,
                      child: Text(value1),
                    );
                  }).toList(),
                  onChanged: (newValue1) {
                    setState(() {
                      selectedValue1 = newValue1;
                    });
                  },
                ),
                const SizedBox(height: 40),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: AppStrings.priorityText,
                    border: OutlineInputBorder(),
                  ),
                  initialValue: priorityValues[1],
                  hint: const Text(
                    AppStrings.priorityText,
                    style: TextStyle(color: Appcolors.white),
                  ),
                  items: priorityValues.map((String prio) {
                    return DropdownMenuItem<String>(
                      value: prio,
                      child: Text(prio),
                    );
                  }).toList(),
                  onChanged: (prioNew) {
                    setState(() {
                      priority = prioNew;
                    });
                  },
                ),

                const SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: AppStrings.requestText,
                    border: OutlineInputBorder(),
                  ),
                  initialValue: listOfOptions[0],
                  hint: const Text(
                    AppStrings.requestText,
                    style: TextStyle(color: Appcolors.white),
                  ),
                  items: listOfOptions.map((String opt) {
                    return DropdownMenuItem<String>(
                      value: opt,
                      child: Text(opt),
                    );
                  }).toList(),
                  onChanged: (optNew) {
                    setState(() {
                      optionsValue = optNew;
                    });
                  },
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: 600,
                  height: 200,
                  child: TextField(
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      hintText: 'Unesite Opis Zahtjeva...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
