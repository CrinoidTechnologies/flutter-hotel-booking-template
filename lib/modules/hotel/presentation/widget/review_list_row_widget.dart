import 'package:flutter/material.dart';
import 'package:motel/app/ui/color_helper.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/modules/_common/widget/rating_bar_widget.dart';
import 'package:motel/modules/hotel/domain/entities/hotel_entity.dart';

class ReviewListRowWidget extends StatelessWidget {
  const ReviewListRowWidget(
      {Key? key,
      this.callback,
      this.reviewsList,
      this.animationController,
      this.animation})
      : super(key: key);

  final VoidCallback? callback;
  final HotelEntity? reviewsList;
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
                0.0, 40 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 48,
                          decoration: BoxDecoration(
                            color: ColorHelper.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: ColorHelper.dividerColor,
                                blurRadius: 8,
                                offset: Offset(4, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                reviewsList!.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            reviewsList!.titleTxt,
                            style: new TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            reviewsList!.dateTxt,
                            style: new TextStyle(
                              fontWeight: FontWeight.w100,
                              color: ColorHelper.disabledColor,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "(${reviewsList!.rating})",
                                style: new TextStyle(
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              RatingBarWidget(
                                rating: reviewsList!.rating / 2,
                                size: 16,
                                activeColor: ColorHelper.primaryColor,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      reviewsList!.subTxt,
                      style: new TextStyle(
                        fontWeight: FontWeight.w100,
                        color: ColorHelper.disabledColor,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                S.of(context).reply,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: ColorHelper.primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 38,
                                width: 26,
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 14,
                                  color: ColorHelper.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 1,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
