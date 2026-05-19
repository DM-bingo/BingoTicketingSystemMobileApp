import 'dart:io';
import 'package:bingo_ticketing_system_mobile/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:bingo_ticketing_system_mobile/strings/app_strings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class CreateNewTicket extends StatefulWidget {
  const CreateNewTicket({super.key});

  @override
  State<CreateNewTicket> createState() => _CreateNewTicket();
}

class _CreateNewTicket extends State<CreateNewTicket> {
  String? selectedValue;
  List<String> options = ['Održavanje objekata', 'IT', 'Sigurnost i Video Nadzor','Motorna vozila'];

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

  Future<http.Response> deleteAlbum(String id) async {
    return await http.delete(
      Uri.parse('url'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> level2Options = _subServiceData[_selectedService] ?? [];
    List<String> level3Options =
        _subServiceData[_selectedSubOptionLevel2] ?? [];

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
                      AppStrings.createTicket,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Appcolors.green2.withValues(),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      initialValue: selectedValue ?? options.first,
                      decoration: InputDecoration(
                        labelText: AppStrings.requestType,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: options
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => selectedValue = v),
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      initialValue: selectedValue1 ?? options1.first,
                      decoration: InputDecoration(
                        labelText: AppStrings.objectText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: options1
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => selectedValue1 = v),
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      initialValue: priority ?? priorityValues[1],
                      decoration: InputDecoration(
                        labelText: AppStrings.priorityText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: priorityValues
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => priority = v),
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      initialValue: optionsValue,
                      decoration: InputDecoration(
                        labelText: AppStrings.requestText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: listOfOptions
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
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

                    const SizedBox(height: 15),

                    if (optionsValue == 'SERVIS')
                      DropdownButtonFormField<String>(
                        initialValue: _selectedService,
                        decoration: InputDecoration(
                          labelText: AppStrings.serviceType,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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

                    const SizedBox(height: 15),

                    if (level2Options.isNotEmpty)
                      DropdownButtonFormField<String>(
                        initialValue: _selectedSubOptionLevel2,
                        decoration: InputDecoration(
                          labelText: AppStrings.chooseOption1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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

                    const SizedBox(height: 15),

                    if (level3Options.isNotEmpty)
                      DropdownButtonFormField<String>(
                        initialValue: _selectedSubOptionLevel3,
                        decoration: InputDecoration(
                          labelText: AppStrings.chooseOption1,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Appcolors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 120,
                            child: TextField(
                              maxLines: null,
                              expands: true,
                              decoration: const InputDecoration(
                                hintText: AppStrings.enterDescription,
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
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image.file(
                                            File(_selectedImages[index].path),
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
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
                                              backgroundColor: Appcolors.red,
                                              child: Icon(
                                                Icons.close,
                                                size: 12,
                                                color: Appcolors.white,
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

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Appcolors.green1, Appcolors.green3],
                          ),
                        ),
                        child: Material(
                          color: Appcolors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: podnesiZahtjev,
                            child: const Center(
                              child: Text(
                                AppStrings.requestSend2,
                                style: TextStyle(
                                  color: Appcolors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
