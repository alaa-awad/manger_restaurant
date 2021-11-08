import 'package:flutter/material.dart';
import 'package:manager_restaurant/layout/manger_restaurant_layout/cubit/cubit.dart';
import 'package:manager_restaurant/modules/add_post/add_post.dart';
import 'package:manager_restaurant/modules/holidays_screen/holidays_screen.dart';
import 'package:manager_restaurant/modules/work_shifts_screen/work_shifts_screen.dart';
import 'package:manager_restaurant/modules/workers_screen/workers_screen.dart';
import 'package:manager_restaurant/shared/component.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    elevation: 5,
                    child: Column(
                      children: [
                        const Image(
                          image: NetworkImage(
                              "https://as1.ftcdn.net/v2/jpg/02/93/81/86/500_F_293818602_X26ysjfABgTrI4AjZivv9RT82SP1Sbrp.jpg"),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 170,
                        ),
                        Text(getTranslated(
                            context, 'HomePageScreen_tittle_holidays_card')),
                      ],
                    ),
                  )),
              onTap: () {
                navigateTo(context, const HolidaysScreen());
              },
            ),
            const SizedBox(height: 10),
            InkWell(
              child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    elevation: 5,
                    child: Column(
                      children: [
                        const Image(
                          image: NetworkImage(
                              "https://as2.ftcdn.net/v2/jpg/03/16/66/03/500_F_316660382_iiUcioiKPtrakXbGjhM6eTZnpN07m7RK.jpg"),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 170,
                        ),
                        Text(getTranslated(
                            context, 'HomePageScreen_tittle_work_shifts_card')),
                      ],
                    ),
                  )),
              onTap: () {
                navigateTo(context, const WorkShiftsScreen());
              },
            ),
            const SizedBox(height: 10),
            if(MangerRestaurantCubit.get(context).userModel?.typeUser != "user")
            InkWell(
              child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    elevation: 5,
                    child: Column(
                      children: [
                        const Image(
                          image: NetworkImage(
                              "https://as1.ftcdn.net/v2/jpg/02/07/86/78/500_F_207867865_7D3EAld4EbR3rL4vuFjc0hDTQ4ok8AU6.jpg"),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 170,
                        ),
                        Text(getTranslated(
                            context, 'HomePageScreen_tittle_workers_card')),
                      ],
                    ),
                  )),
              onTap: () {
                navigateTo(context, const WorkersScreen());
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
