import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../app/ui/appTheme.dart';
import '../../../hotel/domain/entities/hotel_entity.dart';

class SearchTypes extends StatefulWidget {
  @override
  _SearchTypesState createState() => _SearchTypesState();
}

class _SearchTypesState extends State<SearchTypes> with TickerProviderStateMixin {
  List<HotelEntity> hotelTypeList = HotelEntity.hotelTypeList;

  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 114,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 0, right: 16, left: 16),
        itemCount: hotelTypeList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          var count = hotelTypeList.length;
          var animation = Tween(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: animationController,
              curve: Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn),
            ),
          );
          animationController.forward();
          return AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: animation,
                child: new Transform(
                  transform: new Matrix4.translationValues(50 * (1.0 - animation.value), 0.0, 0.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              width: 80,
                              decoration: BoxDecoration(
                                color: AppTheme.getTheme().primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: AppTheme.getTheme().dividerColor,
                                    blurRadius: 8,
                                    offset: Offset(4, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.asset(
                                    hotelTypeList[index].imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.all(Radius.circular(80.0)),
                                highlightColor: Colors.transparent,
                                splashColor: AppTheme.getTheme().primaryColor.withOpacity(0.4),
                                onTap: () {
                                  setState(() {
                                    hotelTypeList[index].isSelected = !hotelTypeList[index].isSelected;
                                  });
                                },
                                child: Opacity(
                                  opacity: hotelTypeList[index].isSelected ? 1.0 : 0.0,
                                  child: Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.getTheme().primaryColor.withOpacity(0.4),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        FontAwesomeIcons.check,
                                        color: AppTheme.getTheme().backgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            hotelTypeList[index].titleTxt,
                            maxLines: 2,
                            style: TextStyle(fontSize: 12),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
