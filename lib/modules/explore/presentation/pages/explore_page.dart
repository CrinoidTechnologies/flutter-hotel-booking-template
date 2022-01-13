import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motel/app/ui/color_helper.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/modules/_common/widget/round_corners_button_widget.dart';
import 'package:motel/modules/explore/presentation/widget/explore_item_header_widget.dart';
import 'package:motel/modules/explore/presentation/widget/explore_slider_widget.dart';
import 'package:motel/modules/explore/presentation/widget/popular_destination_list_widget.dart';
import 'package:motel/modules/hotel/presentation/widget/hotel_row_three_widget.dart';
import '../../../../app/ui/appTheme.dart';
import '../../../hotel/domain/entities/hotel_entity.dart';
import '../../../hotel/presentation/pages/hotel_list_landing_page.dart';
import '../../../hotel/presentation/pages/hotel_details_page.dart';
import '../../../search/presentation/pages/search_page.dart';

class ExplorePage extends StatefulWidget {
  final AnimationController? animationController;

  const ExplorePage({Key? key, this.animationController}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  var hotelList = HotelEntity.hotelList;
  ScrollController? controller;
  late AnimationController _animationController;
  var sliderImageHeight = 0.0;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    widget.animationController!.forward();
    controller = ScrollController(initialScrollOffset: 0.0);

    controller!.addListener(() {
      if (controller!.offset < 0) {
        // we static set the just below half scrolling values
        _animationController.animateTo(0.0);
      } else if (controller!.offset > 0.0 &&
          controller!.offset < sliderImageHeight) {
        // we need around half scrolling values
        if (controller!.offset < ((sliderImageHeight / 1.5))) {
          _animationController
              .animateTo((controller!.offset / sliderImageHeight));
        } else {
          // we static set the just above half scrolling values "around == 0.64"
          _animationController
              .animateTo((sliderImageHeight / 1.5) / sliderImageHeight);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sliderImageHeight = MediaQuery.of(context).size.width * 1.3;
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animationController!,
          // FadeTransition and Transform : just for screen loading animation on fistTime
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 40 * (1.0 - widget.animationController!.value), 0.0),
            child: Scaffold(
              backgroundColor: AppTheme.getTheme().backgroundColor,
              body: Stack(
                children: <Widget>[
                  Container(
                    color: AppTheme.getTheme().backgroundColor,
                    child: ListView.builder(
                      controller: controller,
                      itemCount: 4,
                      // padding on top is only for we need spec for sider
                      padding: EdgeInsets.only(
                          top: sliderImageHeight + 32, bottom: 16),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        // some list UI
                        var count = 4;
                        var animation = Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: widget.animationController!,
                            curve: Interval((1 / count) * index, 1.0,
                                curve: Curves.fastOutSlowIn),
                          ),
                        );
                        if (index == 0) {
                          return ExploreItemHeaderWidget(
                            titleTxt: S.of(context).popularDestinations,
                            subTxt: '',
                            animation: animation,
                            animationController: widget.animationController,
                          );
                        } else if (index == 1) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: PopularDestinationListWidget(
                              animationController: widget.animationController,
                              callBack: (index) {},
                            ),
                          );
                        } else if (index == 2) {
                          return ExploreItemHeaderWidget(
                            titleTxt: S.of(context).bestDeals,
                            subTxt: S.of(context).viewAll,
                            animation: animation,
                            isLeftButton: true,
                            animationController: widget.animationController,
                          );
                        } else {
                          return getDealListView(index);
                        }
                      },
                    ),
                  ),
                  // sliderUI with 3 images are moving
                  _sliderUI(),

                  // viewHotels Button UI for click event
                  _viewHotelsButton(_animationController),

                  //just gradient for see the time and battry Icon on "TopBar"
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        colors: [
                          AppTheme.getTheme().backgroundColor.withOpacity(0.4),
                          AppTheme.getTheme().backgroundColor.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                    ),
                  ),
                  // serachUI on Top  Positioned
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    left: 0,
                    right: 0,
                    child: searchUI(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _viewHotelsButton(AnimationController _animationController) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        var opecity = 1.0 -
            (_animationController.value > 0.64
                ? 1.0
                : _animationController.value);
        return Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: sliderImageHeight * (1.0 - _animationController.value),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 32,
                left: 24,
                child: Opacity(
                  opacity: opecity,
                  child: RoundCornerButtonWidget(
                    title: S.of(context).viewHotels,
                    bgColor: ColorHelper.primaryColor,
                    onTap: () {
                      if (opecity != 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HotelListLandingPage()),
                        );
                      }
                    },
                    padding:
                        EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sliderUI() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget? child) {
          // we calculate the opecity between 0.64 to 1.0
          var opecity = 1.0 -
              (_animationController.value > 0.64
                  ? 1.0
                  : _animationController.value);
          return SizedBox(
            height: sliderImageHeight * (1.0 - _animationController.value),
            child: ExploreSliderWidget(
              opValue: opecity,
              click: () {},
            ),
          );
        },
      ),
    );
  }

  Widget getDealListView(int index) {
    var hotelList = HotelEntity.hotelList;
    List<Widget> list = [];
    hotelList.forEach((f) {
      var animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: widget.animationController!,
          curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      list.add(
        HotelRowThreeWidget(
          callback: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HotelDetailsPage(
                        hotelData: f,
                      ),
                  fullscreenDialog: true),
            );
          },
          hotelData: f,
          animation: animation,
          animationController: widget.animationController,
        ),
      );
    });
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: list,
      ),
    );
  }

  Widget searchUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.getTheme().backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(38)),
          // border: Border.all(
          //   color: HexColor("#757575").withOpacity(0.6),
          // ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppTheme.getTheme().dividerColor,
              blurRadius: 8,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Container(
            height: 48,
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(38)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(),
                        fullscreenDialog: true),
                  );
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.search,
                      size: 18,
                      color: AppTheme.getTheme().primaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextField(
                        maxLines: 1,
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => SearchScreen(), fullscreenDialog: true),
                        //   );
                        // },
                        enabled: false,
                        onChanged: (String txt) {},
                        style: TextStyle(
                          fontSize: 16,
                          // color: AppTheme.dark_grey,
                        ),
                        cursorColor: AppTheme.getTheme().primaryColor,
                        decoration: new InputDecoration(
                          errorText: null,
                          border: InputBorder.none,
                          hintText: S.of(context).whereAreYouGoing,
                          hintStyle: TextStyle(
                              color: AppTheme.getTheme().disabledColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
