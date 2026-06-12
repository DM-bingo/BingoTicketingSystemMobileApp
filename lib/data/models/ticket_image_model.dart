factory TicketImageModel.fromJson(Map<String, dynamic> json) {
  return TicketImageModel(
    imageUrl: json['photoUrl'] ?? json['imageUrl'] ?? "",
  );
}