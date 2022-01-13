import 'package:flutter/material.dart';
import 'package:motel/modules/hotel/domain/entities/hotel_entity.dart';
import 'package:motel/modules/explore/presentation/widget/popular_destination_row_widget.dart';


class PopularDestinationListWidget extends StatefulWidget {
  final Function(int)? callBack;
  final AnimationController? animationController;

  const PopularDestinationListWidget(
      {Key? key, this.callBack, this.animationController})
      : super(key: key);

  @override
  _PopularDestinationListWidgetState createState() =>
      _PopularDestinationListWidgetState();
}

class _PopularDestinationListWidgetState
    extends State<PopularDestinationListWidget> with TickerProviderStateMixin {
  var popularList = HotelEntity.popularList;
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
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
            child: Container(
              height: 180,
              width: double.infinity,
              child: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SizedBox();
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, right: 24, left: 8),
                      itemCount: popularList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var count =
                            popularList.length > 10 ? 10 : popularList.length;
                        var animation = Tween(begin: 0.0, end: 1.0).animate(
                            CurvedAnimation(
                                parent: animationController!,
                                curve: Interval((1 / count) * index, 1.0,
                                    curve: Curves.fastOutSlowIn)));
                        animationController!.forward();
                        return PopularDestinationRowWidget(
                          popularList: popularList[index],
                          animation: animation,
                          animationController: animationController,
                          callback: () {
                            widget.callBack!(index);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
