class TicketModel {
  final int id;
  final String title;
  final String description;
  final List<TicketImageModel> images;
  final String priority;
  final String status;
  final String assignedToUsername;
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
    required this.assignedToUsername,
    required this.createdByUsername,
    required this.categoryName,
    required this.createdAt,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => TicketImageModel.fromJson(e))
              .toList() ??
          [],
      priority: json['priority'],
      status: json['status'],
      assignedToUsername: json['assignedToUsername'],
      createdByUsername: json['createdByUsername'],
      categoryName: json['categoryName'],
      createdAt: json['createdAt'],
    );
  }
}

class TicketImageModel {
  final String photoUrl;

  TicketImageModel({required this.photoUrl});

  factory TicketImageModel.fromJson(Map<String, dynamic> json) {
    return TicketImageModel(photoUrl: json['photoUrl']);
  }
}
