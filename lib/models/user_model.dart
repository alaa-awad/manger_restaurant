class UserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late String image;
  late String typeUser;

//  late bool isEmailVerified;

  UserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.image,
    required this.typeUser,
   // required this.isEmailVerified,
  });

  // json is type from Map<String,dynamic>
  UserModel.fromJson(dynamic json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uId = json['uId'];
    image = json['image'];
    typeUser = json['typeUser'];
    //isEmailVerified = json['isEmailVerified'];
  }

  Map<String,dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'typeUser': typeUser,
     // 'isEmailVerified': isEmailVerified,
    };
  }
}
