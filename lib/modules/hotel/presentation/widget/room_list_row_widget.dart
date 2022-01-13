import 'package:flutter/material.dart';
import 'package:motel/app/ui/color_helper.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/modules/hotel/domain/entities/hotel_entity.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RoomListRowWidget extends StatefulWidget {
  final HotelEntity? roomData;
  final AnimationController? animationController;
  final Animation? animation;

  const RoomListRowWidget(
      {Key? key, this.roomData, this.animationController, this.animation})
      : super(key: key);

  @override
  _RoomListRowWidgetState createState() => _RoomListRowWidgetState();
}

class _RoomListRowWidgetState extends State<RoomListRowWidget> {
  var pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    List<String> images = widget.roomData!.imagePath.split(" ");
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: widget.animation as Animation<double>,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 40 * (1.0 - widget.animation!.value), 0.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: PageView(
                        controller: pageController,
                        pageSnapping: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          for (var image in images)
                            Image.asset(
                              image,
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SmoothPageIndicator(
                        count: 3,
                        effect: WormEffect(
                            radius: 10.0,
                            spacing: 5.0,
                            dotColor: ColorHelper.bgColor,
                            activeDotColor: ColorHelper.primaryColor),
                        controller: pageController,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, bottom: 16, top: 16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.roomData!.titleTxt,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            height: 38,
                            decoration: BoxDecoration(
                              color: ColorHelper.primaryColor,
                              borderRadius:
                              BorderRadius.all(Radius.circular(24.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: ColorHelper.dividerColor,
                                  blurRadius: 8,
                                  offset: Offset(4, 4),
                                ),
                              ],
                            ),
                            child: InkWell(
                              borderRadius:
                              BorderRadius.all(Radius.circular(24.0)),
                              highlightColor: Colors.transparent,
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16),
                                child: Center(
                                  child: Text(
                                    S.of(context).bookNow,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "\$${widget.roomData!.perNight}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              S.of(context).perNight,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ColorHelper
                                      .disabledColor
                                      .withOpacity(0.8)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "${widget.roomData!.dateTxt}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,
                                color: ColorHelper
                                    .disabledColor
                                    .withOpacity(0.4)),
                          ),
                          InkWell(
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.0)),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8, right: 4),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    S.of(context).moreDetails,
                                    style: TextStyle(
                                      // color: AppTheme.getTheme().backgroundColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2),
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      // color: AppTheme.getTheme().backgroundColor,
                                      size: 24,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
