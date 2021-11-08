import 'package:manager_restaurant/models/user_model.dart';

class WorkShiftsModel{

  late String title;
  late String dateBegan;
  late String dateEnd;
  late List<dynamic> users;

  WorkShiftsModel({
    required this.title,
    required this.dateBegan,
    required this.dateEnd,
    required this.users,
});
// json is type from Map<String,dynamic>
  WorkShiftsModel.fromJson(dynamic json) {
    title = json['title'];
    dateBegan = json['dateBegan'];
    dateEnd = json['dateEnd'];
    users = json['users'];

  }

  Map<String,dynamic> toMap() {
    return {
      'title': title,
      'dateBegan': dateBegan,
      'dateEnd': dateEnd,
      'users': users,
    };
  }
}