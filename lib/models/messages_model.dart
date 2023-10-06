class MessagesModel{
  final String senderId;
  final String receiverId;
  final String message;
  final String dateTime;


  MessagesModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,

  });
  factory MessagesModel.fromJson(Map<String,dynamic>json){
    return MessagesModel(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      dateTime: json['dateTime'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "senderId":senderId,
      "receiverId":receiverId,
      "message":message,
      "dateTime":dateTime,
    };
  }
}