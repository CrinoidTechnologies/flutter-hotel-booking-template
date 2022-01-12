import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../app/ui/appTheme.dart';
import '../explore/explore_page.dart';
import '../myTrips/myTripsScreen.dart';
import '../profile/profileScreen.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with TickerProviderStateMixin {
  AnimationController? animationController;
  bool isFirstTime = true;
  Widget currentPage = Container();
  BottomBarType bottomBarType = BottomBarType.Explore;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    currentPage = Container();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _startLoadScreen());
    super.initState();
  }

  Future _startLoadScreen() async {
    await Future.delayed(const Duration(milliseconds: 480));
    setState(() {
      isFirstTime = false;
      currentPage = ExplorePage(
        animationController: animationController,
      );
    });
    animationController?..forward();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: AppTheme.getTheme().backgroundColor,
        bottomNavigationBar: Container(height: 58 + MediaQuery.of(context).padding.bottom, child: getBottomBarUI(bottomBarType)),
        body: isFirstTime
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : currentPage,
      ),
    );
  }

  void tabClick(BottomBarType tabType) {
    if (tabType != bottomBarType) {
      bottomBarType = tabType;
      animationController!.reverse().then((f) {
        if (tabType == BottomBarType.Explore) {
          setState(() {
            currentPage = ExplorePage(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Trips) {
          setState(() {
            currentPage = MyTripsScreen(
              animationController: animationController,
            );
          });
        } else if (tabType == BottomBarType.Profile) {
          setState(() {
            currentPage = ProfileScreen(
              animationController: animationController,
            );
          });
        }
      });
    }
  }

  Widget getBottomBarUI(BottomBarType tabType) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppTheme.getTheme().dividerColor,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: AppTheme.getTheme().primaryColor.withOpacity(0.2),
                    onTap: () {
                      tabClick(BottomBarType.Explore);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 40,
                          height: 32,
                          child: Icon(
                            Icons.search,
                            size: 26,
                            color: tabType == BottomBarType.Explore ? AppTheme.getTheme().primaryColor : AppTheme.getTheme().disabledColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Explore",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: tabType == BottomBarType.Explore ? AppTheme.getTheme().primaryColor : AppTheme.getTheme().disabledColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: AppTheme.getTheme().primaryColor.withOpacity(0.2),
                    onTap: () {
                      tabClick(BottomBarType.Trips);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 40,
                          height: 32,
                          child: Icon(
                            FontAwesomeIcons.heart,
                            color: tabType == BottomBarType.Trips ? AppTheme.getTheme().primaryColor : AppTheme.getTheme().disabledColor,
                            size: 20,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Trips",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: tabType == BottomBarType.Trips ? AppTheme.getTheme().primaryColor : AppTheme.getTheme().disabledColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: AppTheme.getTheme().primaryColor.withOpacity(0.2),
                    onTap: () {
                      tabClick(BottomBarType.Profile);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 4,
                        ),
                        Container(
                          width: 40,
                          height: 32,
                          child: Icon(
                            FontAwesomeIcons.user,
                            color: tabType == BottomBarType.Profile ? AppTheme.getTheme().primaryColor : AppTheme.getTheme().disabledColor,
                            size: 22,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            "Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: tabType == BottomBarType.Profile ? AppTheme.getTheme().primaryColor : AppTheme.getTheme().disabledColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}

enum BottomBarType { Explore, Trips, Profile }
