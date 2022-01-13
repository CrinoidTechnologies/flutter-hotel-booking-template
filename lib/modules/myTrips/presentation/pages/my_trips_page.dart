import 'package:flutter/material.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/modules/_common/widget/selectable_title_widget.dart';
import '../../../../app/ui/appTheme.dart';
import 'favorite_trips_page.dart';
import 'finished_trips_page.dart';
import 'upcoming_trips_page.dart';

class MyTripsPage extends StatefulWidget {
  final AnimationController? animationController;

  const MyTripsPage({Key? key, this.animationController}) : super(key: key);

  @override
  _MyTripsPageState createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage>
    with TickerProviderStateMixin {
  AnimationController? tabAnimationController;

  Widget currentPage = Container();
  TopBarType topBarType = TopBarType.Upcomming;

  @override
  void initState() {
    tabAnimationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    currentPage = UpcomingTripsPage(
      animationController: tabAnimationController,
    );
    tabAnimationController?..forward();
    widget.animationController!.forward();

    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    tabAnimationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animationController!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 40 * (1.0 - widget.animationController!.value), 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Container(child: appBar()),
                ),
                tabViewUI(topBarType),
                Expanded(
                  child: currentPage,
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
      tabAnimationController!.reverse().then((f) {
        if (tabType == TopBarType.Upcomming) {
          currentPage = UpcomingTripsPage(
            animationController: tabAnimationController,
          );
        } else if (tabType == TopBarType.Finished) {
          currentPage = FinishedTripsPage(
            animationController: tabAnimationController,
          );
        } else if (tabType == TopBarType.Favorites) {
          currentPage = FavoriteTripsPage(
            animationController: tabAnimationController,
          );
        }
        setState(() {});
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
                  child: SelectableTitleWidget(
                    title: S.of(context).upcoming,
                    isSelected: tabType == TopBarType.Upcomming,
                    onTap: () {
                      tabClick(TopBarType.Upcomming);
                    },
                  ),
                ),
                Expanded(
                  child: SelectableTitleWidget(
                    title: S.of(context).finished,
                    isSelected: tabType == TopBarType.Finished,
                    onTap: () {
                      tabClick(TopBarType.Finished);
                    },
                  ),
                ),
                Expanded(
                  child: SelectableTitleWidget(
                    title: S.of(context).favorites,
                    isSelected: tabType == TopBarType.Favorites,
                    onTap: () {
                      tabClick(TopBarType.Favorites);
                    },
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
            S.of(context).myTrips,
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
