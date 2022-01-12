import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motel/modules/_common/widget/rating_widget.dart';
import '../../app/ui/appTheme.dart';
import '../../models/hotelListData.dart';
import '../hotelDetailes/roomBookingScreen.dart';

class FavoritesListView extends StatefulWidget {
  final AnimationController? animationController;

  const FavoritesListView({Key? key, this.animationController})
      : super(key: key);

  @override
  _FavoritesListViewState createState() => _FavoritesListViewState();
}

class _FavoritesListViewState extends State<FavoritesListView> {
  var hotelList = HotelListData.hotelList;

  @override
  void initState() {
    widget.animationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: hotelList.length,
        padding: EdgeInsets.only(top: 8, bottom: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var count = hotelList.length > 10 ? 10 : hotelList.length;
          var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: widget.animationController!,
              curve: Interval((1 / count) * index, 1.0,
                  curve: Curves.fastOutSlowIn)));
          widget.animationController!.forward();
          return HotelListView(
            callback: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RoomBookingScreen(
                    hotelName: hotelList[index].titleTxt,
                  ),
                ),
              );
            },
            hotelData: hotelList[index],
            animation: animation,
            animationController: widget.animationController,
          );
        },
      ),
    );
  }
}

class HotelListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback? callback;
  final HotelListData? hotelData;
  final AnimationController? animationController;
  final Animation? animation;

  const HotelListView(
      {Key? key,
      this.hotelData,
      this.animationController,
      this.animation,
      this.callback,
      this.isShowDate: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation as Animation<double>,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.getTheme().backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.getTheme().dividerColor,
                      offset: Offset(4, 4),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  child: AspectRatio(
                    aspectRatio: 2.7,
                    child: Stack(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 0.90,
                              child: Image.asset(
                                hotelData!.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width >= 360
                                        ? 12
                                        : 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      hotelData!.titleTxt,
                                      maxLines: 2,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      hotelData!.subTxt,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.withOpacity(0.8)),
                                    ),
                                    Expanded(
                                      child: SizedBox(),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons
                                                          .mapMarkerAlt,
                                                      size: 12,
                                                      color: AppTheme.getTheme()
                                                          .primaryColor,
                                                    ),
                                                    Text(
                                                      " ${hotelData!.dist.toStringAsFixed(1)} km to city",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.8)),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4),
                                                  child: RatingBarWidget(
                                                    rating: hotelData!.rating,
                                                    size: 20,
                                                    activeColor:
                                                        AppTheme.getTheme()
                                                            .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                "\$${hotelData!.perNight}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 22,
                                                ),
                                              ),
                                              Text(
                                                "/per night",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey
                                                        .withOpacity(0.8)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: AppTheme.getTheme()
                                .primaryColor
                                .withOpacity(0.1),
                            onTap: () {
                              try {
                                callback!();
                              } catch (e) {}
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
