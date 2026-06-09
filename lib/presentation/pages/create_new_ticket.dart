import 'dart:io';
import 'dart:convert';
import 'package:bingo_ticketing_system_mobile/core/constants/app_colors.dart';
import 'package:bingo_ticketing_system_mobile/core/storage/secure_storage.dart';
import 'package:bingo_ticketing_system_mobile/data/services/category_service.dart';
import 'package:bingo_ticketing_system_mobile/data/services/create_new_ticket_service.dart';
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
  int? selectedLocationId;

  int? userLocationId;
  int? userLocationGroupId;

  final List<PriorityItem> priorities = [
    PriorityItem("Nizak", 0),
    PriorityItem("Srednji", 1),
    PriorityItem("Visok", 2),
  ];

  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  final CreateNewTicketService _ticketService = CreateNewTicketService();

  final TextEditingController _descriptionController =
  TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCategories();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final storage = SecureStorage();
    final name = await storage.getUsername();
    final locId = await storage.getLocationId();
    final locGroupId = await storage.getLocationGroupId();

    setState(() {
      username = name;
      userLocationId = locId;
      userLocationGroupId = locGroupId;
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

  Future<void> _pickImages() async {
    final picked = await _picker.pickMultiImage(imageQuality: 50);

    if (picked.isNotEmpty) {
      setState(() {
        _selectedImages.clear();
        _selectedImages.addAll(picked);
      });
    }
  }

  String getSelectedCategoryName() {
    final id =
        selectedLevel4 ?? selectedLevel3 ?? selectedLevel2 ?? selectedLevel1;

    final category = _categories.firstWhere((c) => c.id.toString() == id);

    return category.name;
  }

  Future<List<String>> convertImagesToBase64() async {
    List<String> base64Images = [];

    for (var img in _selectedImages) {
      try {
        final file = File(img.path);
        final bytes = await file.readAsBytes();
        base64Images.add(base64Encode(bytes));
      } catch (e) {
        debugPrint("ERROR IMAGE: $e");
      }
    }

    return base64Images;
  }

  Future<void> createTicket() async {
    final selectedId =
        selectedLevel4 ??
            selectedLevel3 ??
            selectedLevel2 ??
            selectedLevel1;

    if (selectedId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Odaberi kategoriju")),
      );
      return;
    }

    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unesi opis")),
      );
      return;
    }

    int locationToSend;

    if (userLocationGroupId != null) {
      if (selectedLocationId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Odaberi lokaciju")),
        );
        return;
      }
      locationToSend = selectedLocationId!;
    } else {
      locationToSend = userLocationId!;
    }

    final base64Images = await convertImagesToBase64();
    final categoryId = int.parse(selectedId);

    final success = await _ticketService.createTicket(
      categoryId: categoryId,
      priority: selectedPriority!,
      title: getSelectedCategoryName(),
      description: _descriptionController.text,
      photosBase64: base64Images,
      locationId: locationToSend,
    );

    if (!mounted) return;

    if (success) {
      _descriptionController.clear();
      setState(() {
        _selectedImages.clear();
        selectedLevel1 = null;
        selectedLevel2 = null;
        selectedLevel3 = null;
        selectedLevel4 = null;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Tiket kreiran")));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(content: Text("Greška pri kreiranju")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
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
                    const SizedBox(height: 10),
                    TextField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: "Opis...",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: _pickImages,
                      icon: const Icon(Icons.add_a_photo),
                      label: const Text(AppStrings.images),
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
                    ElevatedButton(
                      onPressed: createTicket,
                      child: const Text(AppStrings.send),
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

//komit