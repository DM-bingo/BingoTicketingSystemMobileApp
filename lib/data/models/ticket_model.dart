class TicketModel {
  final int id;
  final String title;
  final String description;
  final List<TicketImageModel> images;
  final String categoryName;
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
    this.categoryName = "",
  });

 factory TicketModel.fromJson(Map<String, dynamic> json) {
  return TicketModel(
    id: json['id'] ?? 0,
    title: json['title'] ?? "",
    description: json['description'] ?? "",
    images: (json['images'] as List<dynamic>?)
        ?.map((e) => TicketImageModel.fromJson(e))
        .toList() ?? [],
    priority: json['priority'] ?? 0,
    statusId: json['statusId'] ?? 0,
    categoryId: json['categoryId'] ?? 0,
    createdByUserId: json['createdByUserId'] ?? 0,
    assignedToUserId: json['assignedToUserId'],
    createdAt: json['createdAt'] ?? "",
    categoryName: json['category']?['name'] ?? "ID ${json['categoryId']}",
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

 String get categoryLabel => categoryName.isNotEmpty ? categoryName : "ID $categoryId";
}