import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:motel/app/ui/appTheme.dart';

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget(
      {Key? key, this.rating, this.activeColor, this.inActiveColor, this.size})
      : super(key: key);
  final double? rating;
  final Color? activeColor;
  final Color? inActiveColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemSize: size ?? 24,
      rating: rating!,
      direction: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return Icon(
          Icons.star,
          color: activeColor ?? AppTheme.getTheme().primaryColor,
        );
      },
      // unratedColor: inActiveColor ?? ColorHelper.lightColor,
    );
  }
}
