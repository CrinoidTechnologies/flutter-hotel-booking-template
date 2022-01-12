import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../app/ui/appTheme.dart';
import '../../models/hotelListData.dart';

class RoomBookingScreen extends StatefulWidget {
  final String? hotelName;

  const RoomBookingScreen({Key? key, this.hotelName}) : super(key: key);

  @override
  _RoomBookingScreenState createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen>
    with TickerProviderStateMixin {
  List<HotelListData> romeList = HotelListData.romeList;
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getTheme().backgroundColor,
      body: Column(
        children: <Widget>[
          getAppBarUI(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemCount: romeList.length,
              itemBuilder: (context, index) {
                var count = romeList.length > 10 ? 10 : romeList.length;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController!,
                        curve: Interval((1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn)));
                animationController!.forward();
                return RoomeBookView(
                  roomData: romeList[index],
                  animation: animation,
                  animationController: animationController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.getTheme().dividerColor,
              offset: Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.hotelName!,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.favorite_border),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoomeBookView extends StatefulWidget {
  final HotelListData? roomData;
  final AnimationController? animationController;
  final Animation? animation;

  const RoomeBookView(
      {Key? key, this.roomData, this.animationController, this.animation})
      : super(key: key);

  @override
  _RoomeBookViewState createState() => _RoomeBookViewState();
}

class _RoomeBookViewState extends State<RoomeBookView> {
  var pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<String> images = widget.roomData!.imagePath.split(" ");
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation as Animation<double>,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 40 * (1.0 - widget.animation!.value), 0.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: PageView(
                        controller: pageController,
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for (var image in images)
                            Image.asset(
                              image,
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmoothPageIndicator(
                        count: 3,
                        effect: WormEffect(
                            radius: 10.0,
                            spacing: 5.0,
                            dotColor: AppTheme.getTheme().backgroundColor,
                            activeDotColor: AppTheme.getTheme().primaryColor),
                        controller: pageController,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.roomData!.titleTxt,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            height: 38,
                            decoration: BoxDecoration(
                              color: AppTheme.getTheme().primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppTheme.getTheme().dividerColor,
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24.0)),
                                highlightColor: Colors.transparent,
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16),
                                  child: Center(
                                    child: Text(
                                      "Book now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "\$${widget.roomData!.perNight}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              "/per night",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.getTheme()
                                      .disabledColor
                                      .withOpacity(0.8)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${widget.roomData!.dateTxt}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,
                                color: AppTheme.getTheme()
                                    .disabledColor
                                    .withOpacity(0.4)),
                          ),
                          InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'More Details',
                                    style: TextStyle(
                                      // color: AppTheme.getTheme().backgroundColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      // color: AppTheme.getTheme().backgroundColor,
                                      size: 24,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
