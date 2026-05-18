import 'dart:io';

import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bingo_ticketing_system_mobile/strings/app_strings.dart';
import 'package:image_picker/image_picker.dart';

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

  List<String> listOfOptions = ['SERVIS', 'NABAVA'];

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

  List<String> listOfElectroOptions = [
    'Elektroinstalacije-Rasvjeta',
    'Agregati',
    'Utičnice',
    'Ups',
    'Trafo Stanica',
    'Razglas',
  ];

  List<String> listOfMachineOptions = [
    'Grijanje',
    'Hlađenje',
    'Ventilacija',
    'Sprinkler',
    'Kuhinjske Nape',
    'Liftovi, Pokretne Stepenice, Travelator',
  ];

  List<String> tehnoloskaOprema2 = [
    'Oprema Za Termičku Obradu Hrane',
    'Rashladna Oprema Kuhinje',
    'Pomoćni Kuhinjski Uređaji',
    'Uređaji/Mašine Za pranje',
    'Salamoreznica',
  ];

  List<String> opremaZaTermickuObraduHrane = [
    'Peć - Konvekcijska',
    'Peć - Pizza',
    'Peć - Pilići',
    'Peć - Fermentacijska',
    'Peć - Štednjak',
    'Roštilj',
    'Friteza',
    'Sać',
    'Kiper',
    'Palačinkar',
  ];

  late final Map<String, List<String>> _subServiceData = {
    'Elektroinstalacije': listOfElectroOptions,
    'Mašinske Instalacije': listOfMachineOptions,
    'Tehnološka Oprema': tehnoloskaOprema2,
    'Oprema Za Termičku Obradu Hrane': opremaZaTermickuObraduHrane,
  };

  String? optionsValue;
  String? _selectedService;
  String? _selectedSubOptionLevel2;
  String? _selectedSubOptionLevel3;

  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  void podnesiZahtjev() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text(AppStrings.requestSend)));
  }

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> level2Options = _subServiceData[_selectedService] ?? [];

    List<String> level3Options =
        _subServiceData[_selectedSubOptionLevel2] ?? [];

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
          child: SingleChildScrollView(
            child: Container(
              width: 600,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Appcolors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    menuMaxHeight: 300,
                    decoration: InputDecoration(
                      labelText: AppStrings.requestType,
                      border: OutlineInputBorder(),
                    ),
                    initialValue: options[0],
                    items: options
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedValue = v),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    menuMaxHeight: 300,
                    decoration: InputDecoration(
                      labelText: AppStrings.objectText,
                      border: OutlineInputBorder(),
                    ),
                    initialValue: options1[0],
                    items: options1
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => selectedValue1 = v),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    menuMaxHeight: 300,
                    decoration: InputDecoration(
                      labelText: AppStrings.priorityText,
                      border: OutlineInputBorder(),
                    ),
                    initialValue: priorityValues[1],
                    items: priorityValues
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => priority = v),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: AppStrings.requestText,
                      border: OutlineInputBorder(),
                    ),
                    initialValue: optionsValue,
                    items: listOfOptions
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        optionsValue = v;
                        _selectedService = null;
                        _selectedSubOptionLevel2 = null;
                        _selectedSubOptionLevel3 = null;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  if (optionsValue == 'SERVIS') ...[
                    DropdownButtonFormField<String>(
                      menuMaxHeight: 300,
                      decoration: const InputDecoration(
                        labelText: 'Tip Servisa',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _selectedService,
                      items: listOfServiceOptions
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          _selectedService = v;
                          _selectedSubOptionLevel2 = null;
                          _selectedSubOptionLevel3 = null;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (level2Options.isNotEmpty) ...[
                    DropdownButtonFormField<String>(
                      menuMaxHeight: 300,
                      decoration: InputDecoration(
                        labelText: AppStrings.chooseOption1,
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _selectedSubOptionLevel2,
                      items: level2Options
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          _selectedSubOptionLevel2 = v;
                          _selectedSubOptionLevel3 = null;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (level3Options.isNotEmpty) ...[
                    DropdownButtonFormField<String>(
                      menuMaxHeight: 300,
                      decoration: InputDecoration(
                        labelText: AppStrings.chooseOption1,
                        border: OutlineInputBorder(),
                      ),
                      initialValue: _selectedSubOptionLevel3,
                      items: level3Options
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          _selectedSubOptionLevel3 = v;
                        });
                      },
                    ),
                  ],
                  const SizedBox(height: 20),
                  Container(
                    width: 600,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 150,
                          child: TextField(
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              hintText: 'Unesite opis zahtjeva...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Divider(),
                        if (_selectedImages.isNotEmpty)
                          SizedBox(
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _selectedImages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        File(_selectedImages[index].path),
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedImages.removeAt(index);
                                            });
                                          },
                                          child: const CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.red,
                                            child: Icon(
                                              Icons.close,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        TextButton.icon(
                          onPressed: _pickImages,
                          icon: const Icon(Icons.add_a_photo),
                          label: const Text(AppStrings.pictureText),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () => podnesiZahtjev(),
                        child: Text(AppStrings.requestSend2),
                      ),
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
