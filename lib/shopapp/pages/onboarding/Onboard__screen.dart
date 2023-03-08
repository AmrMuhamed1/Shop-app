import 'package:flutter/material.dart';
import 'package:shop/shopapp/pages/login/lOGINsCREEN.dart';
import 'package:shop/shopapp/shared_perfernce/cach.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Boradingmodel {
  final String image;
  final String title;
  final String body;

  Boradingmodel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class ONBOARD extends StatefulWidget {
  @override
  State<ONBOARD> createState() => _ONBOARD();
}

class _ONBOARD extends State<ONBOARD> {
  List<Boradingmodel> borading = [
    Boradingmodel(
        image: 'assets/images/amro.jpg',
        title: 'E shopping',
        body: 'Explore our offers '),
    Boradingmodel(
        image: 'assets/images/amro.jpg', title: 'Tittle2', body: 'Screen body'),
    Boradingmodel(
        image: 'assets/images/amro.jpg', title: 'Tittle3', body: 'Screen body'),
  ];
  var controllerboarding = PageController();
  bool islast = false;

  void onsubmit() {
    CacheHelper.setData(key: 'ONBOARD', value: true).then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LOGIN(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Online Shopping'),
          elevation: 5,
          actions: [
            TextButton(
                onPressed: onsubmit,
                child: Text(
                  'Skip',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == borading.length - 1) {
                      setState(() {
                        islast = true;
                      });
                    } else {
                      setState(() {
                        islast = false;
                      });
                    }
                  },
                  controller: controllerboarding,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildBoarding(borading[index]),
                  itemCount: borading.length,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controllerboarding,
                    count: borading.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: Colors.teal,
                      spacing: 5.0,
                      expansionFactor: 4,
                      dotWidth: 10,
                      dotHeight: 10,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (islast) {
                        onsubmit();
                      }
                      controllerboarding.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    },
                    child: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget buildBoarding(Boradingmodel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage(
              '${model.image}',
            ),
            fit: BoxFit.fill,
          )),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          )
        ],
      );
}
