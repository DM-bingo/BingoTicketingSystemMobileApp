class TicketModel {
  final int id;
  final String title;
  final String description;
  final List<TicketImageModel> images;
  final String priority;
  final String status;
  final String createdByUsername;
  final String categoryName;
  final String createdAt;

  TicketModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.priority,
    required this.status,
    required this.createdByUsername,
    required this.categoryName,
    required this.createdAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => TicketImageModel.fromJson(e))
          .toList() ?? [],
      priority: json['priority']?.toString() ?? "Low",
      status: json['status'] ?? "Open",
      createdByUsername: json['createdByUsername'] ?? json['createdByUserId']?.toString() ?? "",
      categoryName: json['category']?['name'] ?? json['categoryName'] ?? "Nepoznato",
      createdAt: json['createdAt'] ?? "",
    );
  }

  String get priorityLabel {
    if (priority == "High") return "Visok";
    if (priority == "Medium") return "Srednji";
    return "Nizak";
  }

  String get statusLabel {
    if (status == "Open") return "Otvoren";
    if (status == "InProgress") return "U radu";
    return "Zatvoren";
  }

  String get categoryLabel => categoryName.isNotEmpty ? categoryName : "Nema kategorije";
}

class TicketImageModel {
  final String imageUrl;

  TicketImageModel({required this.imageUrl});

  factory TicketImageModel.fromJson(Map<String, dynamic> json) {
    return TicketImageModel(
      imageUrl: json['photoUrl'] ?? json['imageUrl'] ?? "",
    );
  }
}
