class PostModel {
  late String name;
  late String uId;
  late String image;
  late String dateTime;
  late String text;
  String? postImage;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
  });

  // json is type from Map<String,dynamic>
  PostModel.fromJson(dynamic json) {
    name = json['name'];
    dateTime = json['dateTime'];
    text = json['text'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
  }

  Map<String,dynamic> toMap() {
    return {
      'name': name,
      'text': text,
      'dateTime': dateTime,
      'uId': uId,
      'image': image,
      'postImage': postImage,
    };
  }
}
