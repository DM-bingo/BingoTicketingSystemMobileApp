import 'dart:io';
import 'package:bingo_ticketing_system_mobile/core/constants/app_colors.dart';
import 'package:bingo_ticketing_system_mobile/core/storage/secure_storage.dart';
import 'package:bingo_ticketing_system_mobile/data/services/category_service.dart';
import 'package:flutter/material.dart';
import 'package:bingo_ticketing_system_mobile/core/constants/app_strings.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bingo_ticketing_system_mobile/data/models/category_model.dart';

class PriorityItem {
  final String label;
  final int value;

  PriorityItem(this.label, this.value);
}

class CreateNewTicket extends StatefulWidget {
  const CreateNewTicket({super.key});

  @override
  State<CreateNewTicket> createState() => _CreateNewTicket();
}

class _CreateNewTicket extends State<CreateNewTicket> {
  List<CategoryModel> _categories = [];
  bool _isLoading = true;

  String? username;

  String? selectedLevel1;
  String? selectedLevel2;
  String? selectedLevel3;
  String? selectedLevel4;

  int? selectedPriority = 1;

  final List<PriorityItem> priorities = [
    PriorityItem("Nizak", 0),
    PriorityItem("Srednji", 1),
    PriorityItem("Visok", 2),
  ];

  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchUsername() async {
    final name = await SecureStorage().getUsername();
    setState(() {
      username = name;
    });
  }

  Future<void> fetchCategories() async {
    try {
      final data = await CategoryService().getCategories();
      setState(() {
        _categories = data;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  List<CategoryModel> getRootCategories() {
    return _categories.where((c) => c.parentId == null).toList();
  }

  List<CategoryModel> getChildren(int parentId) {
    return _categories.where((c) => c.parentId == parentId).toList();
  }

  void podnesiZahtjev() {
    debugPrint(
      "Selected category: ${selectedLevel3 ?? selectedLevel2 ?? selectedLevel1}",
    );
    debugPrint("Selected priority: $selectedPriority");

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
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final level2 = selectedLevel1 == null
        ? []
        : getChildren(int.parse(selectedLevel1!));

    final level3 = selectedLevel2 == null
        ? []
        : getChildren(int.parse(selectedLevel2!));

    final level4 = selectedLevel3 == null
        ? []
        : getChildren(int.parse(selectedLevel3!));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 260,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Appcolors.green1, Appcolors.green2],
                  ),
                ),
                child: const Center(
                  child: Text(
                    AppStrings.createTicket,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: username ?? "",
                      readOnly: true, 
                      decoration: InputDecoration(
                        labelText: "Korisnik",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true, 
                        fillColor: Colors.grey.shade200,
                      ),
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<String>(
                      initialValue: selectedLevel1,
                      decoration: InputDecoration(
                        labelText: "Tip zahtjeva",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: getRootCategories()
                          .map(
                            (c) => DropdownMenuItem(
                              value: c.id.toString(),
                              child: Text(c.name),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          selectedLevel1 = v;
                          selectedLevel2 = null;
                          selectedLevel3 = null;
                          selectedLevel4 = null;
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    if (level2.isNotEmpty)
                      DropdownButtonFormField<String>(
                        initialValue: selectedLevel2,
                        decoration: InputDecoration(
                          labelText: "Podkategorija",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: level2
                            .map(
                              (c) => DropdownMenuItem(
                                value: c.id.toString(),
                                child: Text(c.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          setState(() {
                            selectedLevel2 = v;
                            selectedLevel3 = null;
                            selectedLevel4 = null;
                          });
                        },
                      ),

                    const SizedBox(height: 15),

                    if (level3.isNotEmpty)
                      DropdownButtonFormField<String>(
                        initialValue: selectedLevel3,
                        decoration: InputDecoration(
                          labelText: "Detaljnije",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: level3
                            .map(
                              (c) => DropdownMenuItem(
                                value: c.id.toString(),
                                child: Text(c.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          setState(() {
                            selectedLevel3 = v;
                            selectedLevel4 = null;
                          });
                        },
                      ),

                    const SizedBox(height: 15),

                    if (level4.isNotEmpty)
                      DropdownButtonFormField<String>(
                        initialValue: selectedLevel4,
                        decoration: InputDecoration(
                          labelText: "Poslednja kategorija",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: level4
                            .map(
                              (c) => DropdownMenuItem(
                                value: c.id.toString(),
                                child: Text(c.name),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          setState(() {
                            selectedLevel4 = v;
                          });
                        },
                      ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField<int>(
                      initialValue: selectedPriority,
                      decoration: InputDecoration(
                        labelText: "Prioritet",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: priorities
                          .map(
                            (p) => DropdownMenuItem(
                              value: p.value,
                              child: Text(p.label),
                            ),
                          )
                          .toList(),
                      onChanged: (v) {
                        setState(() {
                          selectedPriority = v;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    const TextField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Opis...",
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextButton.icon(
                      onPressed: _pickImages,
                      icon: const Icon(Icons.add_a_photo),
                      label: const Text("Dodaj slike"),
                    ),

                    if (_selectedImages.isNotEmpty)
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _selectedImages.length,
                          itemBuilder: (_, i) {
                            return Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.file(
                                File(_selectedImages[i].path),
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),

                    const SizedBox(height: 20),

                    /// ✅ SUBMIT
                    ElevatedButton(
                      onPressed: podnesiZahtjev,
                      child: const Text("Pošalji"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
