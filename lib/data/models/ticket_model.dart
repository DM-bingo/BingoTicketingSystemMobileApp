class TicketModel {
  final int id;
  final String title;
  final String description;
  final String photoUrl;
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
    required this.photoUrl,
    required this.priority,
    required this.status,
    required this.assignedToUsername,
    required this.createdByUsername,
    required this.categoryName,
    required this.createdAt
  });

  factory TicketModel.fromJson(Map<String, dynamic> json){
    return TicketModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      photoUrl: json['photoUrl'],
      priority: json['priority'],
      status: json['status'],
      assignedToUsername: json['assignedToUsername'],
      createdByUsername: json['createdByUsername'],
      categoryName: json['categoryName'],
      createdAt: json['createdAt']
    );
  }
}