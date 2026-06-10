import 'dart:io';
import 'dart:convert';
import 'package:bingo_ticketing_system_mobile/core/constants/app_colors.dart';
import 'package:bingo_ticketing_system_mobile/core/storage/secure_storage.dart';
import 'package:bingo_ticketing_system_mobile/data/services/category_service.dart';
import 'package:bingo_ticketing_system_mobile/data/services/create_new_ticket_service.dart';
import 'package:flutter/foundation.dart';
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

  final TextEditingController _descriptionController = TextEditingController();

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

    for(var img in _selectedImages){
      final encoded = await compute(_encodeImage, img.path);
      base64Images.add(encoded);
    }
    return base64Images;

  }
  String _encodeImage(String path){
    final bytes = File(path).readAsBytesSync();
    return base64Encode(bytes);
  }

  Future<void> createTicket() async {
    final selectedId =
        selectedLevel4 ?? selectedLevel3 ?? selectedLevel2 ?? selectedLevel1;

    if (selectedId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Odaberi kategoriju")));
      return;
    }

    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Unesi opis")));
      return;
    }

    int locationToSend;

    if (userLocationGroupId != null) {
      if (selectedLocationId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Odaberi lokaciju")));
        return;
      }
      locationToSend = selectedLocationId!;
    } else {
      locationToSend = userLocationId!;
    }

    setState(() {
      _isLoading = true;
    });

    final base64Images = await convertImagesToBase64();
    final categoryId = int.parse(selectedId);

    setState(() {
      _isLoading = false;
    });

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
      ).showSnackBar(const SnackBar(content: Text("Greška pri kreiranju")));
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
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 220,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Appcolors.green1, Appcolors.green2],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Appcolors.green1.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Center(
                  child: Text(
                    AppStrings.createTicket,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: username ?? "",
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Korisnik",
                      prefixIcon: const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                  const SizedBox(height: 18),
                  DropdownButtonFormField<int>(
                    value: selectedPriority,
                    decoration: InputDecoration(
                      labelText: "Prioritet",
                      prefixIcon: const Icon(Icons.outlined_flag),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
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
                      setState(() => selectedPriority = v);
                    },
                  ),
                  const SizedBox(height: 18),
                  DropdownButtonFormField<String>(
                    value: selectedLevel1,
                    decoration: InputDecoration(
                      labelText: "Tip zahtjeva",
                      prefixIcon: const Icon(Icons.layers_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
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
                  if (level2.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    DropdownButtonFormField<String>(
                      value: selectedLevel2,
                      decoration: InputDecoration(
                        labelText: "Podkategorija",
                        prefixIcon: const Icon(Icons.account_tree_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
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
                  ],
                  const SizedBox(height: 18),
                  TextField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Opis...",
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _pickImages,
                    icon: const Icon(Icons.add_a_photo_outlined),
                    label: const Text(AppStrings.images),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  if (_selectedImages.isNotEmpty) ...[
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _selectedImages.length,
                        itemBuilder: (_, i) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(_selectedImages[i].path),
                                width: 90,
                                cacheWidth: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: createTicket,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Appcolors.green1,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      AppStrings.send,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//komit
