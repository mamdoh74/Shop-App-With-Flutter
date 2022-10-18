import 'package:flutter/material.dart';
import 'package:shopapp/Modules/Shop_Login/ShopLogin.dart';
import 'package:shopapp/Shared/Network/local/Shared_Preferences/Cache_Helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Models/On_BoardingModel.dart';
import '../../Shared/Components/Components.dart';

class On_Boarding extends StatefulWidget {


  @override
  State<On_Boarding> createState() => _On_BoardingState();
}

class _On_BoardingState extends State<On_Boarding> {
  List<OnBoardingModel> onboardingItems=[
    OnBoardingModel(
      image: 'assets/images/onBoard_1.jpg',
      title: 'On board 1 Title',
      body: 'On board 1 body',
    ),
    OnBoardingModel(
      image: 'assets/images/onBoard_2.jpg',
      title: 'On board 2 Title',
      body: 'On board 2 body',
    ),
    OnBoardingModel(
      image: 'assets/images/onBoard_3.jpg',
      title: 'On board 3 Title',
      body: 'On board 3 body',
    ),
  ];

  var boardController = PageController();

  bool islast=false;

  void submitScreen(){
    CacheHelper.PutData(key: 'isSkipped', value: true).then((value){
      navigateToAndReplace(ShopLogin(), context);
    }).catchError((error){

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){
              submitScreen();
            },
            child: Text(
              'SKIP'
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                  onPageChanged: (index){
                  if (index == onboardingItems.length-1)
                    {
                      setState(() {
                        islast=true;
                      });
                      print('last');
                    }
                  else {
                    print('not last');
                    setState(() {
                      islast=false;
                    });

                  }
                  },
                  itemBuilder: (context, index) => OnBoardingItem(onboardingItems[index]),
                  itemCount: onboardingItems.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 10,
                      activeDotColor: Colors.deepPurple,
                    ),
                    count: onboardingItems.length,
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(islast)
                    {
                      submitScreen();
                    }
                  else{
                    boardController.nextPage(
                      duration: Duration(
                          milliseconds: 750
                      ),
                      curve: Curves.bounceInOut,
                    );
                  }

                },
                child: Icon(
                  Icons.arrow_forward_ios,
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
