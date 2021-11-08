import 'package:manager_restaurant/models/user_model.dart';

class HolidayModel{

  late String dateHoliday;
   String? dateFinishHoliday;
  late List<dynamic> users;

  HolidayModel({
    required this.dateHoliday,
    this.dateFinishHoliday,
    required this.users,
  });
// json is type from Map<String,dynamic>
  HolidayModel.fromJson(dynamic json) {
    dateHoliday = json['dateHoliday'];
    dateFinishHoliday = json['dateFinishHoliday'];
    users = json['users'];

  }

  Map<String,dynamic> toMap() {
    return {
      'dateHoliday': dateHoliday,
      'dateFinishHoliday': dateFinishHoliday,
      'users': users,
    };
  }
}