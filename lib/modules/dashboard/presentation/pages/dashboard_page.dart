import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/modules/_common/widget/selectable_title_widget.dart';
import '../../../../app/ui/appTheme.dart';
import '../../../explore/presentation/pages/explore_page.dart';
import '../../../myTrips/presentation/pages/my_trips_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  bool isFirstTime = true;
  Widget currentPage = Container();
  BottomBarType bottomBarType = BottomBarType.Explore;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
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
        bottomNavigationBar: Container(
            height: 58 + MediaQuery.of(context).padding.bottom,
            child: getBottomBarUI(bottomBarType)),
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
          currentPage = ExplorePage(
            animationController: animationController,
          );
        } else if (tabType == BottomBarType.Trips) {
          currentPage = MyTripsPage(
            animationController: animationController,
          );
        } else if (tabType == BottomBarType.Profile) {
          currentPage = ProfilePage(
            animationController: animationController,
          );
        }
        setState(() {});
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
                child: SelectableTitleWidget(
                  title: S.of(context).explore,
                  showRoundedCornerRipple: false,
                  drawable: Icon(FontAwesomeIcons.search),
                  isSelected: tabType == BottomBarType.Explore,
                  onTap: () {
                    tabClick(BottomBarType.Explore);
                  },
                ),
              ),
              Expanded(
                child: SelectableTitleWidget(
                  title: S.of(context).trips,
                  showRoundedCornerRipple: false,
                  drawable: Icon(FontAwesomeIcons.heart),
                  isSelected: tabType == BottomBarType.Trips,
                  onTap: () {
                    tabClick(BottomBarType.Trips);
                  },
                ),
              ),
              Expanded(
                child: SelectableTitleWidget(
                  title: S.of(context).profile,
                  showRoundedCornerRipple: false,
                  drawable: Icon(FontAwesomeIcons.user),
                  isSelected: tabType == BottomBarType.Profile,
                  onTap: () {
                    tabClick(BottomBarType.Profile);
                  },
                ),
              ),
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
