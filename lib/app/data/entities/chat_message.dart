class ChatMessage {
  final int id;
  final String sender;
  final String message;
  final String reciever;
  final String daySended;

  ChatMessage(
      {required this.id,
      required this.sender,
      required this.message,
      required this.reciever,
      required this.daySended});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json["id"],
      sender: json["sender"],
      message: json["message"],
      reciever: json["reciever"],
      daySended: json["daySended"],
    );
  }
}
