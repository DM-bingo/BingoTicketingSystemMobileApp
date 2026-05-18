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

  late final Map<String, List<String>> _subServiceData = {
    'Elektroinstalacije': listOfElectroOptions,
    'Mašinske Instalacije': listOfMachineOptions,
  };

  String? optionsValue;
  String? _selectedService;
  String? _selectedSubOption;

  List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

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
    List<String> currentSubOptions = _subServiceData[_selectedService] ?? [];

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
            height: 800,
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
                      _selectedService = null;
                      _selectedSubOption = null;
                    });
                  },
                ),

                const SizedBox(height: 20),

                if (optionsValue == 'SERVIS') ...[
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Tip Servisa',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: _selectedService,
                    hint: const Text('Izaberi tip servisa'),
                    items: listOfServiceOptions.map((String service) {
                      return DropdownMenuItem<String>(
                        value: service,
                        child: Text(service),
                      );
                    }).toList(),
                    onChanged: (newService) {
                      setState(() {
                        _selectedService = newService;
                        _selectedSubOption = null;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                ],

                if (optionsValue == 'SERVIS' &&
                    currentSubOptions.isNotEmpty) ...[
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Specifična opcija',
                      border: OutlineInputBorder(),
                    ),
                    initialValue: _selectedSubOption,
                    hint: const Text('Izaberite opciju'),
                    items: currentSubOptions.map((String subOpt) {
                      return DropdownMenuItem<String>(
                        value: subOpt,
                        child: Text(subOpt),
                      );
                    }).toList(),
                    onChanged: (newSubOpt) {
                      setState(() {
                        _selectedSubOption = newSubOpt;
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 150,
                        child: TextField(
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
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
                        label: const Text('Priloži slike'),
                      ),
                    ],
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
