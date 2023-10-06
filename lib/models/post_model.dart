class PostModel{
  final String name;
  final String uId;
  final String image;
  final String dateTime;
  final String text;
  final String postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });
  factory PostModel.fromJson(Map<String,dynamic>json){
    return PostModel(
        name: json['name'],
        uId: json['uId'],
        image: json['image'],
        dateTime: json['dateTime'],
        text: json['text'],
        postImage: json['postImage'],
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "name":name,
      "uId":uId,
      "image":image,
      "dateTime":dateTime,
      'text':text,
      'postImage':postImage,
    };
  }
}