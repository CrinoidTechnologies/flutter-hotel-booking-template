import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/modules/hotel/presentation/widget/hotel_map_view_row_widget.dart';
import 'package:motel/modules/hotel/presentation/widget/hotel_row_one_widget.dart';
import '../../../../app/ui/appTheme.dart';
import '../../domain/entities/hotel_entity.dart';
import '../widget/calendar_popup_widget.dart';
import '../widget/room_range_selection_widget.dart';
import 'room_list_page.dart';
import '../../../search/presentation/pages/search_page.dart';
import '../../../search/presentation/pages/filters_page.dart';

class HotelListLandingPage extends StatefulWidget {
  @override
  _HotelListLandingPageState createState() => _HotelListLandingPageState();
}

class _HotelListLandingPageState extends State<HotelListLandingPage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  late AnimationController _animationController;
  var hotelList = HotelEntity.hotelList;
  ScrollController scrollController = new ScrollController();
  int room = 1;
  int ad = 2;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 5));
  bool isMap = false;

  final searchBarHeight = 158.0;
  final filterBarHeight = 52.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _animationController =
        AnimationController(duration: Duration(milliseconds: 0), vsync: this);
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        _animationController.animateTo(0.0);
      } else if (scrollController.offset > 0.0 &&
          scrollController.offset < searchBarHeight) {
        // we need around searchBarHieght scrolling values in 0.0 to 1.0
        _animationController
            .animateTo((scrollController.offset / searchBarHeight));
      } else {
        _animationController.animateTo(1.0);
      }
    });
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Column(
              children: <Widget>[
                getAppBarUI(),
                isMap
                    ? Expanded(
                        child: Column(
                          children: <Widget>[
                            getSearchBarUI(),
                            getTimeDateUI(),
                            Expanded(
                              child: Stack(
                                children: <Widget>[
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image.asset(
                                          "assets/images/mapImage.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        height: 80,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppTheme.getTheme()
                                                  .scaffoldBackgroundColor
                                                  .withOpacity(1.0),
                                              AppTheme.getTheme()
                                                  .scaffoldBackgroundColor
                                                  .withOpacity(0.0),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                      ),
                                    ] +
                                    getMapPinUI() +
                                    [
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: Container(
                                          height: 156,
                                          // color: Colors.green,
                                          child: ListView.builder(
                                            itemCount: hotelList.length,
                                            padding: EdgeInsets.only(
                                                top: 8, bottom: 8, right: 16),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return HotelMapViewRowWidget(
                                                callback: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RoomListPage(
                                                        hotelName:
                                                            hotelList[index]
                                                                .titleTxt,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                hotelData: hotelList[index],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                              ),
                            )
                          ],
                        ),
                      )
                    : Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              color: AppTheme.getTheme().backgroundColor,
                              child: ListView.builder(
                                controller: scrollController,
                                itemCount: hotelList.length,
                                padding: EdgeInsets.only(
                                  top: 8 + 158 + 52.0,
                                ),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  var count = hotelList.length > 10
                                      ? 10
                                      : hotelList.length;
                                  var animation = Tween(begin: 0.0, end: 1.0)
                                      .animate(CurvedAnimation(
                                          parent: animationController!,
                                          curve: Interval(
                                              (1 / count) * index, 1.0,
                                              curve: Curves.fastOutSlowIn)));
                                  animationController!.forward();
                                  return HotelRowOneWidget(
                                    callback: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => RoomListPage(
                                            hotelName:
                                                hotelList[index].titleTxt,
                                          ),
                                        ),
                                      );
                                    },
                                    hotelData: hotelList[index],
                                    animation: animation,
                                    animationController: animationController,
                                  );
                                },
                              ),
                            ),
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (BuildContext context, Widget? child) {
                                return Positioned(
                                  top: -searchBarHeight *
                                      (_animationController.value),
                                  left: 0,
                                  right: 0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        color: AppTheme.getTheme()
                                            .scaffoldBackgroundColor,
                                        child: Column(
                                          children: <Widget>[
                                            getSearchBarUI(),
                                            getTimeDateUI(),
                                          ],
                                        ),
                                      ),
                                      getFilterBarUI(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getMapPinUI() {
    List<Widget> list = [];

    for (var i = 0; i < hotelList.length; i++) {
      double? top;
      double? left;
      double? right;
      double? bottom;
      if (i == 0) {
        top = 150;
        left = 50;
      } else if (i == 1) {
        top = 50;
        right = 50;
      } else if (i == 2) {
        top = 40;
        left = 10;
      } else if (i == 3) {
        bottom = 260;
        right = 140;
      } else if (i == 4) {
        bottom = 160;
        right = 20;
      }
      list.add(
        Positioned(
          top: top,
          left: left,
          right: right,
          bottom: bottom,
          child: Container(
            decoration: BoxDecoration(
              color: hotelList[i].isSelected
                  ? AppTheme.getTheme().primaryColor
                  : AppTheme.getTheme().backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppTheme.getTheme().dividerColor,
                  blurRadius: 16,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
                onTap: () {
                  if (hotelList[i].isSelected == false) {
                    setState(() {
                      hotelList.forEach((f) {
                        f.isSelected = false;
                      });
                      hotelList[i].isSelected = true;
                    });
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  child: Text(
                    "\$${hotelList[i].perNight}",
                    style: TextStyle(
                        color: hotelList[i].isSelected
                            ? AppTheme.getTheme().backgroundColor
                            : AppTheme.getTheme().primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: AppTheme.getTheme().dividerColor,
              offset: Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder(
              future: getData(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: hotelList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var count = hotelList.length > 10 ? 10 : hotelList.length;
                      var animation = Tween(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController!,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                      animationController!.forward();
                      return HotelRowOneWidget(
                        callback: () {},
                        hotelData: hotelList[index],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHotelViewList() {
    List<Widget> hotelListViews = [];
    for (var i = 0; i < hotelList.length; i++) {
      var count = hotelList.length;
      var animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        HotelRowOneWidget(
          callback: () {},
          hotelData: hotelList[i],
          animation: animation,
          animationController: animationController,
        ),
      );
    }
    animationController!.forward();
    return Column(
      children: hotelListViews,
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    // setState(() {
                    //   isDatePopupOpen = true;
                    // });
                    showDemoDialog(context: context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          S.of(context).chooseDate,
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.8)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          RoomRangeSelectionWidget(
                        ad: 2,
                        room: 1,
                        ch: 0,
                        barrierDismissible: true,
                        onChnage: (ro, a, c) {
                          setState(() {
                            room = ro;
                            ad = a;
                          });
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          S.of(context).numberOfRooms,
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                              color: Colors.grey.withOpacity(0.8)),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "$room Room - $ad Adults",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.getTheme().backgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.getTheme().dividerColor,
                        offset: Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPage(),
                            fullscreenDialog: true),
                      );
                    },
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: AppTheme.getTheme().primaryColor,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: S.of(context).london,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.getTheme().primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppTheme.getTheme().dividerColor,
                    offset: Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPage(),
                        fullscreenDialog: true),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20, color: AppTheme.getTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: AppTheme.getTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppTheme.getTheme().dividerColor,
                    offset: Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: AppTheme.getTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "530 hotels found",
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FiltersPage(),
                            fullscreenDialog: true),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            S.of(context).filter,
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                color: AppTheme.getTheme().primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  void showDemoDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CalendarPopupWidget(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime? startData, DateTime? endData) {
          setState(() {
            if (startData != null && endData != null) {
              startDate = startData;
              endDate = endData;
            }
          });
        },
        onCancelClick: () {},
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
              width: AppBar().preferredSize.height + 40,
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
                  S.of(context).explore,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.favorite_border),
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      setState(() {
                        isMap = !isMap;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                          isMap ? Icons.sort : FontAwesomeIcons.mapMarkedAlt),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
