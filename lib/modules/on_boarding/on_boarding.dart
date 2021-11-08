import 'package:flutter/material.dart';
import 'package:manager_restaurant/modules/login_screen/manger_restaurant_login_screen.dart';
import 'package:manager_restaurant/shared/adaptive/adaptive_button.dart';
import 'package:manager_restaurant/shared/component.dart';
import 'package:manager_restaurant/shared/constant.dart';
import 'package:manager_restaurant/shared/network/local/cache_helper.dart';
import 'package:manager_restaurant/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

 // late BuildContext context;
_OnBoardingScreenState();



  bool isLast = false;

  void submit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value)
    {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    List<BoardingModel> boarding = [
      BoardingModel(
        image: 'https://as2.ftcdn.net/v2/jpg/03/16/66/03/500_F_316660382_iiUcioiKPtrakXbGjhM6eTZnpN07m7RK.jpg',
        title: getTranslated(context, 'onboard_1_title'),
        body: getTranslated(context, 'onboard_1_body'),
      ),
      BoardingModel(
        image: 'https://as1.ftcdn.net/v2/jpg/02/93/81/86/500_F_293818602_X26ysjfABgTrI4AjZivv9RT82SP1Sbrp.jpg',
        title: getTranslated(context, 'onboard_2_title'),
        body: getTranslated(context, 'onboard_2_body'),
      ),
      BoardingModel(
        image: 'https://image.freepik.com/free-photo/work-space-business-media-concept_53876-139674.jpg',
        title: getTranslated(context, 'onboard_3_title'),
        body: getTranslated(context, 'onboard_3_body'),
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem2(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            SmoothPageIndicator(
              controller: boardController,
              effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: defaultColor,
                dotHeight: 10,
                expansionFactor: 4,
                dotWidth: 10,
                spacing: 5.0,
              ),
              count: boarding.length,
            ),
            const SizedBox(
              height: 40.0,
            ),
            AdaptiveButton(
              function: () {
                if (isLast)
                {
                  submit();
                } else {
                  boardController.nextPage(
                    duration: const Duration(
                      milliseconds: 750,
                    ),
                    curve: Curves.fastLinearToSlowEaseIn,
                  );
                }
              },
              os: getOs(),
              text: isLast?getTranslated(context, 'onboard_3_button_start'):
              getTranslated(context, 'onboard_3_button_skip'),),
          /*  Row(
              children: [

                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast)
                    {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),*/
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem2(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 12.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14.0,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      CircleAvatar(
        backgroundImage: NetworkImage(model.image),
        radius: 150,



  ),


    ],
  );

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(model.image),
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14.0,
        ),
      ),
      const SizedBox(
        height: 30.0,
      ),
    ],
  );
}