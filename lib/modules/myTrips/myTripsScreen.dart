import 'package:flutter/material.dart';
import '../../app/ui/appTheme.dart';
import '../myTrips/favoritesListView.dart';
import '../myTrips/finishTripView.dart';
import '../myTrips/upcomingListView.dart';

class MyTripsScreen extends StatefulWidget {
  final AnimationController animationController;

  const MyTripsScreen({Key key, this.animationController}) : super(key: key);
  @override
  _MyTripsScreenState createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> with TickerProviderStateMixin {
  AnimationController tabAnimationController;

  Widget indexView = Container();
  TopBarType topBarType = TopBarType.Upcomming;

  @override
  void initState() {
    tabAnimationController = AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    indexView = UpcomingListView(
      animationController: tabAnimationController,
    );
    tabAnimationController..forward();
    widget.animationController.forward();

    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    tabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animationController,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 40 * (1.0 - widget.animationController.value), 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Container(child: appBar()),
                ),
                tabViewUI(topBarType),
                Expanded(
                  child: indexView,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void tabClick(TopBarType tabType) {
    if (tabType != topBarType) {
      topBarType = tabType;
      tabAnimationController.reverse().then((f) {
        if (tabType == TopBarType.Upcomming) {
          setState(() {
            indexView = UpcomingListView(
              animationController: tabAnimationController,
            );
          });
        } else if (tabType == TopBarType.Finished) {
          setState(() {
            indexView = FinishTripView(
              animationController: tabAnimationController,
            );
          });
        } else if (tabType == TopBarType.Favorites) {
          setState(() {
            indexView = FavoritesListView(
              animationController: tabAnimationController,
            );
          });
        }
      });
    }
  }

  Widget tabViewUI(TopBarType tabType) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
          color: AppTheme.getTheme().dividerColor.withOpacity(0.05),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      highlightColor: Colors.transparent,
                      splashColor: AppTheme.getTheme().primaryColor.withOpacity(0.2),
                      onTap: () {
                        tabClick(TopBarType.Upcomming);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16),
                        child: Center(
                          child: Text(
                            "Upcoming",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: tabType == TopBarType.Upcomming
                                    ? AppTheme.getTheme().primaryColor
                                    : AppTheme.getTheme().disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      highlightColor: Colors.transparent,
                      splashColor: AppTheme.getTheme().primaryColor.withOpacity(0.2),
                      onTap: () {
                        tabClick(TopBarType.Finished);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16),
                        child: Center(
                          child: Text(
                            "Finished",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: tabType == TopBarType.Finished
                                    ? AppTheme.getTheme().primaryColor
                                    : AppTheme.getTheme().disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      highlightColor: Colors.transparent,
                      splashColor: AppTheme.getTheme().primaryColor.withOpacity(0.2),
                      onTap: () {
                        tabClick(TopBarType.Favorites);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16, top: 16),
                        child: Center(
                          child: Text(
                            "Favorites",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: tabType == TopBarType.Favorites
                                    ? AppTheme.getTheme().primaryColor
                                    : AppTheme.getTheme().disabledColor),
                          ),
                        ),
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
      ),
    );
  }

  Widget appBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 24 + 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "My Trips",
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

enum TopBarType { Upcomming, Finished, Favorites }
