class UserModel{
  final String name;
  final String email;
  final String phone;
  final String uId;
  final String image;
  final String bio;
  final String cover;
  final bool isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.image,
    required this.bio,
    required this.cover,
    required this.isEmailVerified

  });
  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        uId: json['uId'],
        image: json['image'] ,
        bio: json['bio'],
        cover: json['cover'],
        isEmailVerified:json['isEmailVerified']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      "name":name,
      "email":email,
      "phone":phone,
      "uId":uId,
      'image':image,
      'bio':bio,
      'cover':cover,
      "isEmailVerified":isEmailVerified
    };
  }
}