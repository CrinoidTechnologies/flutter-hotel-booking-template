import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../app/ui/appTheme.dart';
import '../../models/hotelListData.dart';
import '../hotelDetailes/roomBookingScreen.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FinishTripView extends StatefulWidget {
  final AnimationController animationController;

  const FinishTripView({Key key, this.animationController}) : super(key: key);

  @override
  _FinishTripViewState createState() => _FinishTripViewState();
}

class _FinishTripViewState extends State<FinishTripView> {
  var hotelList = HotelListData.hotelList;

  @override
  void initState() {
    widget.animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: hotelList.length,
        padding: EdgeInsets.only(top: 8, bottom: 16),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var count = hotelList.length > 10 ? 10 : hotelList.length;
          var animation = Tween(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(parent: widget.animationController, curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn)));
          widget.animationController.forward();
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
            isShowDate: (index % 2) != 0,
          );
        },
      ),
    );
  }
}

class HotelListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation animation;

  const HotelListView({Key key, this.hotelData, this.animationController, this.animation, this.callback, this.isShowDate: false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                onTap: () {
                  try {
                    callback();
                  } catch (e) {}
                },
                child: Row(
                  children: <Widget>[
                    isShowDate ? getUI(context) : SizedBox(),
                    Container(
                      height: 150,
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
                          aspectRatio: 1.0,
                          child: Image.asset(
                            hotelData.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    !isShowDate ? getUI(context) : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getUI(BuildContext context) {
    return Expanded(
      child: Container(
        height: 150,
        padding: EdgeInsets.only(left: !isShowDate ? 16 : 8, top: 8, bottom: 8, right: isShowDate ? 16 : 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: isShowDate ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              hotelData.titleTxt,
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              hotelData.subTxt,
              style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
            ),
            Text(
              hotelData.dateTxt,
              maxLines: 2,
              textAlign:isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              hotelData.roomSizeTxt,
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: SizedBox(),
            ),
            Row(
              mainAxisAlignment: isShowDate ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  size: 12,
                  color: AppTheme.getTheme().primaryColor,
                ),
                Text(
                  " ${hotelData.dist.toStringAsFixed(1)} km to city",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: SmoothStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: hotelData.rating,
                size: 16,
                color: AppTheme.getTheme().primaryColor,
                borderColor: AppTheme.getTheme().primaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: isShowDate ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "\$${hotelData.perNight}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    "/per night",
                    style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
