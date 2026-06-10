class TicketModel {
  final int id;
  final String title;
  final String description;
  final List<TicketImageModel> images;

  final int priority;
  final int statusId;
  final int categoryId;

  final int createdByUserId;
  final int? assignedToUserId;

  final String createdAt;

  TicketModel({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.priority,
    required this.statusId,
    required this.categoryId,
    required this.createdByUserId,
    this.assignedToUserId,
    required this.createdAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => TicketImageModel.fromJson(e))
          .toList() ??
          [],
      priority: json['priority'] ?? 0,
      statusId: json['statusId'] ?? 0,
      categoryId: json['categoryId'] ?? 0,
      createdByUserId: json['createdByUserId'] ?? 0,
      assignedToUserId: json['assignedToUserId'],
      createdAt: json['createdAt'] ?? "",
    );
  }

  String get priorityLabel {
    if (priority == 2) return "Visok";
    if (priority == 1) return "Srednji";
    return "Nizak";
  }

  String get statusLabel {
    if (statusId == 1) return "Otvoren";
    if (statusId == 2) return "U radu";
    return "Zatvoren";
  }

  String get categoryLabel => "ID $categoryId";
}

class TicketImageModel {
  final String photoUrl;

  TicketImageModel({required this.photoUrl});

  factory TicketImageModel.fromJson(Map<String, dynamic> json) {
    return TicketImageModel(
      photoUrl: json['imageUrl'] ?? json['ImageUrl'] ?? "",
    );
  }
}