import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/models/holiday_model.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/styles/colors.dart';

import 'add_holiday.dart';

class HolidaysScreen extends StatelessWidget {
  const HolidaysScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MangerRestaurantCubit, MangerRestaurantStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateTo(context, AddHoliday());
              },
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: MangerRestaurantCubit.get(context).holidayModels.isEmpty
                ? Container()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return cardItemWorkShift(
                          MangerRestaurantCubit.get(context)
                              .holidayModels[index],
                          context);
                    },
                    itemCount: MangerRestaurantCubit.get(context)
                        .holidayModels
                        .length),
          );
        });
  }

  Widget cardItemWorkShift(HolidayModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Column(
              children: [
                Center(
                    child: Text(model.dateHoliday,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.blue,
                            ))),
                const SizedBox(
                  height: 10,
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
                          Text('${index + 1} - ${model.users[index]}'),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: model.users.length),
                if(model.dateFinishHoliday !=null)
                const SizedBox(height: 25,),
                if(model.dateFinishHoliday !=null)
               Row(children: [
                 Text(getTranslated(context, 'Holidays_Screen_text_dateFinishHoliday')),
                 const Spacer(),
                 Text("${model.dateFinishHoliday}"),
               ],),
                const SizedBox(
                  height: 40,
                ),
              ],
            )),
      ),
    );
  }
}
