class MessageModel {
  late String dateTime;
   String? receiverId;
  late String senderId;
  late String text;
  late String type;
  String? nameSender;

  MessageModel({
    required this.dateTime,
     this.receiverId,
    required this.senderId,
    required this.text,
    required this.type,
    this.nameSender,

  });

  // json is type from Map<String,dynamic>
  MessageModel.fromJson(dynamic json) {
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    text = json['text'];
    type = json['type'];
    nameSender = json['nameSender'];

  }

  Map<String,dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'receiverId': receiverId,
      'senderId': senderId,
      'text': text,
      'type': type,
      'nameSender': nameSender,
    };
  }
}
