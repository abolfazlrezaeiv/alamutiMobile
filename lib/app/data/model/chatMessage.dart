class ChatMessage {
  late int id;
  late String sender;

  late String message;
  late String reciever;
  late String daySended;
  ChatMessage(
      {required this.id,
      required this.sender,
      required this.message,
      required this.reciever,
      required this.daySended});
  // late DateTime DateSended { get; set; }

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    sender = json["sender"];
    message = json["message"];
    reciever = json["reciever"];
    daySended = json["daySended"];
  }
}