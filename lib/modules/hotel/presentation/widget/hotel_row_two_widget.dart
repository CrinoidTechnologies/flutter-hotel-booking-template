import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motel/app/ui/appTheme.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/modules/hotel/domain/entities/hotel_entity.dart';
import 'package:motel/modules/_common/widget/rating_bar_widget.dart';

class HotelRowTwoWidget extends StatelessWidget {
  const HotelRowTwoWidget(
      {Key? key,
      this.isShowDate: false,
      this.callback,
      this.hotelData,
      this.animationController,
      this.animation})
      : super(key: key);

  final bool isShowDate;
  final VoidCallback? callback;
  final HotelEntity? hotelData;
  final AnimationController? animationController;
  final Animation? animation;

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
              child: InkWell(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                onTap: () {
                  try {
                    callback!();
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
                            hotelData!.imagePath,
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
        padding: EdgeInsets.only(
            left: !isShowDate ? 16 : 8,
            top: 8,
            bottom: 8,
            right: isShowDate ? 16 : 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              isShowDate ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              hotelData!.titleTxt,
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              hotelData!.subTxt,
              style:
                  TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
            ),
            Text(
              hotelData!.dateTxt,
              maxLines: 2,
              textAlign: isShowDate ? TextAlign.right : TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              hotelData!.roomSizeTxt,
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
              mainAxisAlignment:
                  isShowDate ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.mapMarkerAlt,
                  size: 12,
                  color: AppTheme.getTheme().primaryColor,
                ),
                Text(
                  " ${hotelData!.dist.toStringAsFixed(1)} km to city",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: RatingBarWidget(
                rating: hotelData!.rating,
                size: 16,
                activeColor: AppTheme.getTheme().primaryColor,
              ),
            ),
            Row(
              mainAxisAlignment:
                  isShowDate ? MainAxisAlignment.end : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  "\$${hotelData!.perNight}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    S.of(context).perNight,
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey.withOpacity(0.8)),
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
