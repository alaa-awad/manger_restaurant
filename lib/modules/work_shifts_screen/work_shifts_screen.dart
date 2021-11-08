import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/states.dart';
import 'package:manager_restaurant/models/work_shift_model.dart';
import 'package:manager_restaurant/modules/work_shifts_screen/add_work_shift.dart';
import 'package:manager_restaurant/shared/component.dart';

class WorkShiftsScreen extends StatelessWidget {
  const WorkShiftsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MangerRestaurantCubit, MangerRestaurantStates>(
        listener: (context, state) {},
        builder: (context, state) {
          print(
              'work shift ${MangerRestaurantCubit.get(context).workShiftModels}');
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateTo(context, AddWorkShift());
              },
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: MangerRestaurantCubit.get(context).workShiftModels.isEmpty
                ? Container()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return cardItemWorkShift(
                          MangerRestaurantCubit.get(context)
                              .workShiftModels[index],
                          context);
                    },
                    itemCount: MangerRestaurantCubit.get(context)
                        .workShiftModels
                        .length),
          );
        });
  }

  Widget cardItemWorkShift(WorkShiftsModel model, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
      child: Card(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
            child: Column(
              children: [
                Center(
                    child: Text(model.title,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            ))),
                const SizedBox(
                  height: 0,
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        Text('Began Date',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.blue,
                                    )),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(model.dateBegan),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text('End Date',
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Colors.blue,
                                    )),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(model.dateEnd),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  child: myDivider(),
                  height: 7,
                ),
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
                const SizedBox(
                  height: 40,
                ),
              ],
            )),
      ),
    );
  }
}
