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
  List<CategoryModel> _rootCategories = [];
  bool _isLoading = true;

  String? username;

  List<String?> selectedLevels = [];

  int? selectedPriority = 1;
  int? selectedLocationId;

  int? userLocationId;
  int? userLocationGroupId;

  final List<PriorityItem> priorities = [
    PriorityItem(AppStrings.priority0, 0),
    PriorityItem(AppStrings.priority1, 1),
    PriorityItem(AppStrings.priority2, 2),
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

    if (!mounted) return;

    setState(() {
      username = name;
      userLocationId = locId;
      userLocationGroupId = locGroupId;
    });
  }

  Future<void> fetchCategories() async {
    try {
      final data = await CategoryService().getCategories();

      if (!mounted) return;

      setState(() {
        _categories = data;
        _rootCategories = data.where((c) => c.parentId == null).toList();
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  List<CategoryModel> getChildrenOf(String? parentId) {
    if (parentId == null) return _rootCategories;

    return _categories.where((c) => c.parentId == int.parse(parentId)).toList();
  }

  Future<void> _pickImages() async {
    final picked = await _picker.pickMultiImage(imageQuality: 50);

    if (picked.isNotEmpty) {
      setState(() {
        _selectedImages
          ..clear()
          ..addAll(picked);
      });
    }
  }

  Future<void> _openCamera() async {
    final photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (photo != null) {
      setState(() {
        _selectedImages.add(photo);
      });
    }
  }

  String getSelectedCategoryName() {
    if (selectedLevels.isEmpty) return "";
    final category = _categories.firstWhere(
      (c) => c.id.toString() == selectedLevels.last,
    );
    return category.name;
  }

  Future<List<String>> convertImagesToBase64() async {
    final futures = _selectedImages.map(
      (img) => compute(_encodeImage, img.path),
    );
    return await Future.wait(futures);
  }

  static String _encodeImage(String path) {
    final bytes = File(path).readAsBytesSync();
    return base64Encode(bytes);
  }

  Future<void> createTicket() async {
    final selectedId = selectedLevels.isNotEmpty ? selectedLevels.last : null;

    if (selectedId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.chooseCategory)));
      return;
    }

    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.enterDesc)));
      return;
    }

    late int locationToSend;

    if (userLocationGroupId != null) {
      final loc = selectedLocationId;
      if (loc == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.chooseLocation)),
        );
        return;
      }
      locationToSend = loc;
    } else if (userLocationId != null) {
      locationToSend = userLocationId!;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.locationNotAvailable)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final base64Images = await convertImagesToBase64();

    final success = await _ticketService.createTicket(
      categoryId: int.parse(selectedId),
      priority: selectedPriority ?? 1,
      title: getSelectedCategoryName(),
      description: _descriptionController.text,
      photosBase64: base64Images,
      locationId: locationToSend,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (success) {
      _descriptionController.clear();
      setState(() {
        _selectedImages.clear();
        selectedLevels.clear();
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.ticketCreated)));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(AppStrings.error)));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: ListView(
        padding: EdgeInsets.zero,
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
                  color: Appcolors.green2.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
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
                    fontSize: 26,
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
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                DropdownButtonFormField<int>(
                  initialValue: selectedPriority,
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
                  onChanged: (v) => setState(() => selectedPriority = v),
                ),
                const SizedBox(height: 18),
                Column(
                  children: List.generate(selectedLevels.length + 1, (index) {
                    final parentId = index == 0
                        ? null
                        : selectedLevels[index - 1];
                    final options = getChildrenOf(parentId);

                    if (options.isEmpty) return const SizedBox();

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: DropdownButtonFormField<String>(
                        initialValue: index < selectedLevels.length
                            ? selectedLevels[index]
                            : null,
                        decoration: InputDecoration(
                          labelText: index == 0
                              ? AppStrings.requestType
                              : AppStrings.subCategory,
                          prefixIcon: index == 0
                              ? const Icon(Icons.layers_outlined)
                              : const Icon(Icons.account_tree_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        items: options
                            .map(
                              (c) => DropdownMenuItem(
                                value: c.id.toString(),
                                child: Text(c.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            if (index < selectedLevels.length) {
                              selectedLevels[index] = value;
                              selectedLevels = selectedLevels.sublist(
                                0,
                                index + 1,
                              );
                            } else {
                              selectedLevels.add(value);
                            }
                          });
                        },
                      ),
                    );
                  }),
                ),
                TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "Opis",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _pickImages,
                        icon: const Icon(Icons.photo_library_outlined),
                        label: const Text(AppStrings.gallery),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _openCamera,
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text(AppStrings.camera),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_selectedImages.isNotEmpty) ...[
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImages.length,
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(_selectedImages[i].path),
                                  width: 100,
                                  height: 100,
                                  cacheWidth: 150,
                                  filterQuality: FilterQuality.low,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedImages.removeAt(i);
                                    });
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: const Icon(
                                      Icons.close,
                                      size: 14,
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
                ],
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isLoading ? null : createTicket,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Appcolors.green1,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
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
    );
  }
}
