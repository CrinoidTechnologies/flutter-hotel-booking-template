import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motel/app/ui/color_helper.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/modules/_common/widget/rating_bar_widget.dart';
import 'package:motel/modules/_common/widget/round_corners_button_widget.dart';
import 'package:motel/modules/hotel/presentation/widget/review_list_row_widget.dart';
import '../../../../app/ui/appTheme.dart';
import '../../domain/entities/hotel_entity.dart';
import '../widget/room_images_widget.dart';
import '../widget/hotel_rating_widget.dart';
import 'review_list_page.dart';
import 'room_list_page.dart';

class HotelDetailsPage extends StatefulWidget {
  final HotelEntity? hotelData;

  const HotelDetailsPage({Key? key, this.hotelData}) : super(key: key);

  @override
  _HotelDetailsPageState createState() => _HotelDetailsPageState();
}

class _HotelDetailsPageState extends State<HotelDetailsPage>
    with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController(initialScrollOffset: 0);
  var hotelText1 =
      "Featuring a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum...";
  var hotelText2 =
      "Featuring a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum a fitness center, Grand Royale Park Hote is located in Sweden, 4.7 km frome National Museum";
  bool isFav = false;
  bool isReadLess = false;
  AnimationController? animationController;
  var imageHeight = 0.0;
  late AnimationController _animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    animationController!.forward();
    scrollController.addListener(() {
      if (scrollController.offset < 0) {
        // we static set the just below half scrolling values
        _animationController.animateTo(0.0);
      } else if (scrollController.offset > 0.0 &&
          scrollController.offset < imageHeight) {
        // we need around half scrolling values
        if (scrollController.offset < ((imageHeight / 1.2))) {
          _animationController
              .animateTo((scrollController.offset / imageHeight));
        } else {
          // we static set the just above half scrolling values "around == 0.22"
          _animationController.animateTo((imageHeight / 1.2) / imageHeight);
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
    imageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppTheme.getTheme().backgroundColor,
      body: Stack(
        children: <Widget>[
          Container(
            color: AppTheme.getTheme().backgroundColor,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.only(top: 24 + imageHeight),
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
                          S.of(context).summary,
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
                          text: !isReadLess ? hotelText1 : hotelText2,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.getTheme().disabledColor,
                          ),
                          recognizer: new TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: !isReadLess ? S.of(context).readMore : S.of(context).less,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.getTheme().primaryColor,
                          ),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              setState(() {
                                isReadLess = !isReadLess;
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
                  child: HotelRatingWidget(hotelData: widget.hotelData),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          S.of(context).photos,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                S.of(context).viewAll,
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
                      )
                    ],
                  ),
                ),
                RoomImagesWidget(),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          S.of(context).reviews8,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReviewListPage(),
                                fullscreenDialog: true),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                S.of(context).viewAll,
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
                      )
                    ],
                  ),
                ),
                ReviewListRowWidget(
                  reviewsList: HotelEntity.reviewsList[0],
                  animation: animationController,
                  animationController: animationController,
                ),
                ReviewListRowWidget(
                  reviewsList: HotelEntity.reviewsList[1],
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
                  child: getBookNowButton(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                ),
              ],
            ),
          ),
          _backgroundImageUI(widget.hotelData),
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _backgroundImageUI(HotelEntity? hotelData) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          var opacity = 1.0 -
              (_animationController.value >= ((imageHeight / 1.2) / imageHeight)
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: imageHeight * (1.0 - _animationController.value),
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
                    opacity: opacity,
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
                                      child: getBookNowButton(),
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
                                          S.of(context).moreDetails,
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
              S.of(context).perNight,
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

  Widget getBookNowButton() => RoundCornerButtonWidget(
        title: S.of(context).bookNow,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomListPage(
                hotelName: widget.hotelData!.titleTxt,
              ),
              fullscreenDialog: true,
            ),
          );
        },
        bgColor: ColorHelper.primaryColor,
      );
}
