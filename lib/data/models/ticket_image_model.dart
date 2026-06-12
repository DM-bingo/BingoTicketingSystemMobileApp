class TicketImageModel {
final String imageUrl;

TicketImageModel({required this.imageUrl});

factory TicketImageModel.fromJson(Map<String, dynamic>json){
  return TicketImageModel(imageUrl: json['imageUrl'] ?? "",);
}
}