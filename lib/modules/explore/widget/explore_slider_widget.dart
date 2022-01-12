import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import '../../../app/ui/appTheme.dart';
import '../../onBoadring/introductionScreen.dart';

class ExploreSliderWidget extends StatefulWidget {
  final double opValue;
  final VoidCallback click;

  const ExploreSliderWidget({Key key, this.opValue = 0.0, this.click}) : super(key: key);
  @override
  _ExploreSliderWidgetState createState() => _ExploreSliderWidgetState();
}

class _ExploreSliderWidgetState extends State<ExploreSliderWidget> {
  var pageController = PageController(initialPage: 0);
  var pageViewModelData = List<PageViewData>();

  Timer sliderTimer;
  var currentShowIndex = 0;

  @override
  void initState() {
    pageViewModelData.add(PageViewData(
      titleText: 'Cape Town',
      subText: 'Extraordinary five-star\noutdoor activites',
      assetsImage: 'assets/images/explore_2.jpg',
    ));
    pageViewModelData.add(PageViewData(
      titleText: 'Find best deals',
      subText: 'Extraordinary five-star\noutdoor activites',
      assetsImage: 'assets/images/explore_1.jpg',
    ));
    pageViewModelData.add(PageViewData(
      titleText: 'Find best deals',
      subText: 'Extraordinary five-star\noutdoor activites',
      assetsImage: 'assets/images/explore_3.jpg',
    ));

    sliderTimer = Timer.periodic(Duration(seconds: 4), (timer) {
      if (currentShowIndex == 0) {
        pageController.animateTo(MediaQuery.of(context).size.width, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 1) {
        pageController.animateTo(MediaQuery.of(context).size.width * 2, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      } else if (currentShowIndex == 2) {
        pageController.animateTo(0, duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sliderTimer?.cancel();
    pageController?.dispose();
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
            child: PageIndicator(
              layout: PageIndicatorLayout.WARM,
              size: 10.0,
              controller: pageController,
              space: 5.0,
              count: 3,
              color: Colors.white,
              activeColor: AppTheme.getTheme().primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class PagePopup extends StatelessWidget {
  final PageViewData imageData;
  final double opValue;

  const PagePopup({Key key, this.imageData, this.opValue: 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.width * 1.3),
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            imageData.assetsImage,
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
                    imageData.titleText,
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
                    imageData.subText,
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
