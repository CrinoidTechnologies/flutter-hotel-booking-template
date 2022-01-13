import 'dart:async';
import 'package:flutter/material.dart';
import 'package:motel/app/ui/appTheme.dart';
import 'package:motel/app/ui/color_helper.dart';
import 'package:motel/modules/_common/entity/slider_entity.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ExploreSliderWidget extends StatefulWidget {
  final double opValue;
  final VoidCallback? click;

  const ExploreSliderWidget({Key? key, this.opValue = 0.0, this.click})
      : super(key: key);

  @override
  _ExploreSliderWidgetState createState() => _ExploreSliderWidgetState();
}

class _ExploreSliderWidgetState extends State<ExploreSliderWidget> {
  var pageController = PageController(initialPage: 0);
  var pageViewModelData = [];

  Timer? sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.addAll(SliderData.exploreSliderData);

    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          PageView(
            controller: pageController,
            pageSnapping: true,
            onPageChanged: (index) {
              currentShowIndex = index;
            },
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              PagePopup(
                imageData: pageViewModelData[0],
                opValue: widget.opValue,
              ),
              PagePopup(
                imageData: pageViewModelData[1],
                opValue: widget.opValue,
              ),
              PagePopup(
                imageData: pageViewModelData[2],
                opValue: widget.opValue,
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            right: 32,
            child: SmoothPageIndicator(
              count: 3,
              effect: WormEffect(
                  radius: 10.0,
                  spacing: 5.0,
                  dotColor: ColorHelper.lightColor,
                  activeDotColor: AppTheme.getTheme().primaryColor),
              controller: pageController,
            ),
          ),
        ],
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final SliderData? imageData;
  final double opValue;

  const PagePopup({Key? key, this.imageData, this.opValue: 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.width * 1.3),
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            imageData!.assetsImage!,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 80,
          left: 24,
          child: Opacity(
            opacity: opValue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    imageData!.titleText!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Text(
                    imageData!.subText!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
