import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/manger_restaurant_layout.dart';
import 'package:manager_restaurant/modules/holidays_screen/holidays_screen.dart';
import 'package:manager_restaurant/modules/work_shifts_screen/work_shifts_screen.dart';
import 'package:manager_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:manager_restaurant/shared/adaptive/adaptive_text_field.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/constant.dart';
import 'package:manager_restaurant/shared/icon_broken.dart';
import 'package:manager_restaurant/shared/styles/colors.dart';

class AddHoliday extends StatelessWidget {
  AddHoliday({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  var dateHolidayController = TextEditingController();
  var dateHolidayFinishController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<bool> isChoosing = [];
    for (var element in usersNumber) {
      isChoosing.add(false);
    }
    List<String> usersHoliday = [];
    return BlocConsumer<MangerRestaurantCubit, MangerRestaurantStates>(
      listener: (context, state) {
        if (state is AddHolidaySuccessState) {
          MangerRestaurantCubit.get(context).getHoliday();
        //  navigateAndFinish(context, const HolidaysScreen());
          navigateAndFinish(context, const MangerRestaurantLayout());
        }
      },
      builder: (context, state) {
        MangerRestaurantCubit mangerCubit = MangerRestaurantCubit.get(context);

        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          getTranslated(
                              context, 'Add_Holiday_Screen_title_page'),
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2022-05-03'),
                                ).then((value) {
                                  dateHolidayController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              icon: const Icon(Icons.date_range)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AdaptiveTextField(
                              os: getOs(),
                              label: getTranslated(
                                  context, 'Add_Holiday_Screen_textFiled_date'),
                              controller: dateHolidayController,
                              type: TextInputType.datetime,
                              textInputAction: TextInputAction.next,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return getTranslated(context,
                                      'Add_Holiday_Screen_textFiled_date_validate');
                                }
                              },
                              inputBorder: const OutlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: defaultColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2022-05-03'),
                                ).then((value) {
                                  dateHolidayFinishController.text =
                                      DateFormat.yMMMd().format(value!);
                                });
                              },
                              icon: const Icon(Icons.date_range)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: AdaptiveTextField(
                              os: getOs(),
                              label: getTranslated(
                                  context, 'Add_Holiday_Screen_textFiled_dateFinish'),
                              controller: dateHolidayFinishController,
                              type: TextInputType.datetime,
                              textInputAction: TextInputAction.next,
                              inputBorder: const OutlineInputBorder(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: defaultColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                    '${index + 1} - ${usersNumber[index].name}'),
                                const Spacer(),
                                !isChoosing[index]
                                    ? IconButton(
                                        onPressed: () {
                                          usersHoliday.add(
                                              usersNumber[index].name);
                                          isChoosing[index] = true;
                                          mangerCubit.emit(
                                              AddHolidayChangeIconButtonState());
                                        },
                                        icon: const Icon(IconBroken.Add_User,
                                            color: Colors.green))
                                    : IconButton(
                                        onPressed: () {

                                          usersHoliday.remove(
                                              usersNumber[index].name);
                                          isChoosing[index] = false;
                                          mangerCubit.emit(
                                              AddHolidayChangeIconButtonState());
                                        },
                                        icon: const Icon(
                                          IconBroken.Delete,
                                          color: Colors.red,
                                        )),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },

                          itemCount: usersNumber.length),
                      const SizedBox(
                        height: 20,
                      ),
                      state is! AddHolidayLoadingState ||
                              state is AddHolidayErrorState
                          ? AdaptiveButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  mangerCubit.addHoliday(
                                    dateHoliday: dateHolidayController.text,
                                    dateFinishHoliday:
                                        dateHolidayFinishController.text.isNotEmpty?
                                        dateHolidayFinishController.text:null
                                    ,
                                    users: usersHoliday,
                                  );
                                }
                              },
                              text: getTranslated(context,
                                  'Add_Holiday_Screen_button_add_Holiday'),
                              isUpperCase: true,
                              background: defaultColor,
                              os: getOs(),
                            )
                          : const Center(child: CircularProgressIndicator())
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
