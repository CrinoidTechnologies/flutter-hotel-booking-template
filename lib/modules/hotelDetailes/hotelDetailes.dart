import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motel/modules/_common/widget/rating_widget.dart';
import '../../app/ui/appTheme.dart';
import '../../models/hotelListData.dart';
import '../hotelDetailes/hotelRoomeList.dart';
import '../hotelDetailes/ratingView.dart';
import '../hotelDetailes/reviewsListScreen.dart';
import '../hotelDetailes/roomBookingScreen.dart';

class HotelDetailes extends StatefulWidget {
  final HotelListData? hotelData;

  const HotelDetailes({Key? key, this.hotelData}) : super(key: key);

  @override
  _HotelDetailesState createState() => _HotelDetailesState();
}

class _HotelDetailesState extends State<HotelDetailes>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  var hoteltext1 =
      "Featuring a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum...";
  var hoteltext2 =
      "Featuring a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum";
  bool isFav = false;
  bool isReadless = false;
  AnimationController? animationController;
  var imageHieght = 0.0;
  late AnimationController _animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    animationController!.forward();
    scrollController.addListener(() {
      if (context != null) {
        if (scrollController.offset < 0) {
          // we static set the just below half scrolling values
          _animationController.animateTo(0.0);
        } else if (scrollController.offset > 0.0 &&
            scrollController.offset < imageHieght) {
          // we need around half scrolling values
          if (scrollController.offset < ((imageHieght / 1.2))) {
            _animationController
                .animateTo((scrollController.offset / imageHieght));
          } else {
            // we static set the just above half scrolling values "around == 0.22"
            _animationController.animateTo((imageHieght / 1.2) / imageHieght);
          }
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    imageHieght = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppTheme.getTheme().backgroundColor,
      body: Stack(
        children: <Widget>[
          Container(
            color: AppTheme.getTheme().backgroundColor,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 24 + imageHieght),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: getHotelDetails(isInList: true),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Summary",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 24, right: 24, top: 4, bottom: 8),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: !isReadless ? hoteltext1 : hoteltext2,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.getTheme().disabledColor,
                          ),
                          recognizer: new TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: !isReadless ? ' Read more' : " less",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.getTheme().primaryColor,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isReadless = !isReadless;
                              });
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 8,
                    bottom: 16,
                  ),
                  child: RatingView(hotelData: widget.hotelData),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Photos",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'View all',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppTheme.getTheme().primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 38,
                                  width: 26,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 18,
                                    color: AppTheme.getTheme().primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                HotelRoomeList(),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "Reviews (8)",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReviewsListScreen(),
                                  fullscreenDialog: true),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'View all',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppTheme.getTheme().primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 38,
                                  width: 26,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    size: 14,
                                    color: AppTheme.getTheme().primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ReviewsView(
                  reviewsList: HotelListData.reviewsList[0],
                  animation: animationController,
                  animationController: animationController,
                ),
                ReviewsView(
                  reviewsList: HotelListData.reviewsList[1],
                  animation: animationController,
                  animationController: animationController,
                ),
                SizedBox(
                  height: 16,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: Image.asset(
                        "assets/images/mapImage.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 34, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.getTheme().primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            FontAwesomeIcons.mapPin,
                            color: AppTheme.getTheme().backgroundColor,
                            size: 28,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 16),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppTheme.getTheme().primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
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
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RoomBookingScreen(
                                hotelName: widget.hotelData!.titleTxt,
                              ),
                              fullscreenDialog: true,
                            ),
                          );
                        },
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
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),
          _backgraoundImageUI(widget.hotelData),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              height: AppBar().preferredSize.height,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    height: AppBar().preferredSize.height,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, left: 8),
                      child: Container(
                        width: AppBar().preferredSize.height - 8,
                        height: AppBar().preferredSize.height - 8,
                        decoration: BoxDecoration(
                            color: AppTheme.getTheme()
                                .disabledColor
                                .withOpacity(0.4),
                            shape: BoxShape.circle),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {
                              if (scrollController.offset != 0.0) {
                                scrollController.animateTo(0.0,
                                    duration: Duration(milliseconds: 480),
                                    curve: Curves.easeInOutQuad);
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back,
                                  color: AppTheme.getTheme().backgroundColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  SizedBox(
                    height: AppBar().preferredSize.height,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, right: 8),
                      child: Container(
                        width: AppBar().preferredSize.height - 8,
                        height: AppBar().preferredSize.height - 8,
                        decoration: BoxDecoration(
                            color: AppTheme.getTheme().backgroundColor,
                            shape: BoxShape.circle),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                            onTap: () {
                              setState(() {
                                isFav = !isFav;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: AppTheme.getTheme().primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _backgraoundImageUI(HotelListData? hotelData) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          var opecity = 1.0 -
              (_animationController.value >= ((imageHieght / 1.2) / imageHieght)
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: imageHieght * (1.0 - _animationController.value),
            child: Stack(
              children: <Widget>[
                IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.getTheme().primaryColor,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppTheme.getTheme().dividerColor,
                          blurRadius: 8,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          top: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              hotelData!.imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom + 16,
                  left: 0,
                  right: 0,
                  child: Opacity(
                    opacity: opecity,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            child: new BackdropFilter(
                              filter: new ImageFilter.blur(
                                  sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                color: Colors.black12,
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16, top: 8),
                                      child: getHotelDetails(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          bottom: 16,
                                          top: 16),
                                      child: Container(
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color:
                                              AppTheme.getTheme().primaryColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(24.0)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                              color: AppTheme.getTheme()
                                                  .dividerColor,
                                              blurRadius: 8,
                                              offset: Offset(4, 4),
                                            ),
                                          ],
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24.0)),
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RoomBookingScreen(
                                                    hotelName:
                                                        hotelData.titleTxt,
                                                  ),
                                                  fullscreenDialog: true,
                                                ),
                                              );
                                            },
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
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            child: new BackdropFilter(
                              filter: new ImageFilter.blur(
                                  sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                color: Colors.black12,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    highlightColor: Colors.transparent,
                                    splashColor: AppTheme.getTheme()
                                        .primaryColor
                                        .withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(38)),
                                    onTap: () {
                                      try {
                                        scrollController.animateTo(
                                            MediaQuery.of(context).size.height -
                                                MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    5,
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.fastOutSlowIn);
                                      } catch (e) {}
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 4,
                                          bottom: 4),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            'More Details',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget getHotelDetails({bool isInList = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.hotelData!.titleTxt,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: isInList
                      ? AppTheme.getTheme().textTheme.bodyText1!.color
                      : Colors.white,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.hotelData!.subTxt,
                    style: TextStyle(
                      fontSize: 14,
                      color: isInList
                          ? AppTheme.getTheme().disabledColor.withOpacity(0.5)
                          : Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    size: 12,
                    color: AppTheme.getTheme().primaryColor,
                  ),
                  Expanded(
                    child: Text(
                      "${widget.hotelData!.dist.toStringAsFixed(1)} km to city",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: isInList
                            ? AppTheme.getTheme().disabledColor.withOpacity(0.5)
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              isInList
                  ? SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: <Widget>[
                          RatingBarWidget(
                            rating: widget.hotelData!.rating,
                            size: 20,
                            activeColor: AppTheme.getTheme().primaryColor,
                          ),
                          Text(
                            " ${widget.hotelData!.reviews} Reviews",
                            style: TextStyle(
                              fontSize: 14,
                              color: isInList
                                  ? AppTheme.getTheme().disabledColor
                                  : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "\$${widget.hotelData!.perNight}",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: isInList
                    ? AppTheme.getTheme().textTheme.bodyText1!.color
                    : Colors.white,
              ),
            ),
            Text(
              "/per night",
              style: TextStyle(
                fontSize: 14,
                color: isInList
                    ? AppTheme.getTheme().disabledColor.withOpacity(0.5)
                    : Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
