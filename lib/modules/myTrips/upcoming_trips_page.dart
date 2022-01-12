import 'package:flutter/material.dart';
import 'package:motel/modules/hotel/widget/hotel_row_one_widget.dart';
import '../../models/hotelListData.dart';
import '../../modules/hotel_details/roomBookingScreen.dart';

class UpcomingTripsPage extends StatefulWidget {
  final AnimationController? animationController;

  const UpcomingTripsPage({Key? key, this.animationController})
      : super(key: key);

  @override
  _UpcomingTripsPageState createState() => _UpcomingTripsPageState();
}

class _UpcomingTripsPageState extends State<UpcomingTripsPage> {
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
        padding: EdgeInsets.only(top: 8, bottom: 16),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var count = hotelList.length > 10 ? 10 : hotelList.length;
          var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: widget.animationController!,
              curve: Interval((1 / count) * index, 1.0,
                  curve: Curves.fastOutSlowIn)));
          widget.animationController!.forward();
          return HotelRowOneWidget(
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
            isShowDate: true,
          );
        },
      ),
    );
  }
}
