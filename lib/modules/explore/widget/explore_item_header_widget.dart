import 'package:flutter/material.dart';
import '../../../app/ui/appTheme.dart';

class ExploreItemHeaderWidget extends StatelessWidget {
  final String titleTxt;
  final String subTxt;
  final AnimationController? animationController;
  final Animation? animation;
  final VoidCallback? click;
  final bool isLeftButton;

  const ExploreItemHeaderWidget(
      {Key? key,
      this.titleTxt: "",
      this.subTxt: "",
      this.animationController,
      this.animation,
      this.click,
      this.isLeftButton: false})
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
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      titleTxt,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  isLeftButton
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            onTap: () {
                              click!();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    subTxt,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: AppTheme.getTheme().primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 38,
                                    width: 26,
                                    child: Icon(
                                      Icons.arrow_forward,
                                      size: 18,
                                      color: AppTheme.getTheme().primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
