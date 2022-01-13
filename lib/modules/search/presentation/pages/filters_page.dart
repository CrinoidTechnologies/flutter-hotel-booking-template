import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motel/generated/l10n.dart';
import '../../../../app/ui/appTheme.dart';
import '../../domain/entities/filter_entity.dart';
import '../widgets/range_slider_widget.dart';
import '../widgets/slider_widget.dart';

class FiltersPage extends StatefulWidget {
  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  List<FilterEntity> popularFilterListData =
      FilterEntity.popularFList;
  List<FilterEntity> accommodationListData =
      FilterEntity.accomodationList;

  RangeValues _values = RangeValues(100, 600);
  double distValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.getTheme().backgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: appBar(),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    children: <Widget>[
                      priceBarFilter(),
                      Divider(
                        height: 1,
                      ),
                      popularFilter(),
                      Divider(
                        height: 1,
                      ),
                      distanceViewUI(),
                      Divider(
                        height: 1,
                      ),
                      allAccommodationUI()
                    ],
                  ),
                ),
              ),
            ),
            Divider(
              height: 1,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 16 + MediaQuery.of(context).padding.bottom,
                  top: 8),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: AppTheme.getTheme().primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppTheme.getTheme().dividerColor,
                      blurRadius: 8,
                      offset: Offset(4, 4),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Center(
                    child: Text(
                      S.of(context).apply,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget allAccommodationUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            S.of(context).typeOfAccommodation,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getAccommodationListUI(),
          ),
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getAccommodationListUI() {
    List<Widget> noList = [];
    for (var i = 0; i < accommodationListData.length; i++) {
      final date = accommodationListData[i];
      noList.add(
        InkWell(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          onTap: () {
            setState(() {
              checkAppPosition(i);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    date.titleTxt,
                    // style: TextStyle(color: Colors.white),
                  ),
                ),
                CupertinoSwitch(
                  activeColor: date.isSelected
                      ? AppTheme.getTheme().primaryColor
                      : Colors.grey.withOpacity(0.6),
                  onChanged: (value) {
                    setState(() {
                      checkAppPosition(i);
                    });
                  },
                  value: date.isSelected,
                ),
              ],
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(Divider(
          height: 1,
        ));
      }
    }
    return noList;
  }

  void checkAppPosition(int index) {
    if (index == 0) {
      if (accommodationListData[0].isSelected) {
        accommodationListData.forEach((d) {
          d.isSelected = false;
        });
      } else {
        accommodationListData.forEach((d) {
          d.isSelected = true;
        });
      }
    } else {
      accommodationListData[index].isSelected =
          !accommodationListData[index].isSelected;

      var count = 0;
      for (var i = 0; i < accommodationListData.length; i++) {
        if (i != 0) {
          var data = accommodationListData[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == accommodationListData.length - 1) {
        accommodationListData[0].isSelected = true;
      } else {
        accommodationListData[0].isSelected = false;
      }
    }
  }

  Widget distanceViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            S.of(context).distanceFromCityCenter,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        SliderWidget(
          distValue: distValue,
          onChnagedistValue: (value) {
            if (value != null) distValue = value;
          },
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  Widget popularFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            S.of(context).popularFilters,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getPList(),
          ),
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getPList() {
    List<Widget> noList = [];
    var cout = 0;
    final columCount = 2;
    for (var i = 0; i < popularFilterListData.length / columCount; i++) {
      List<Widget> listUI = [];
      for (var i = 0; i < columCount; i++) {
        try {
          final date = popularFilterListData[cout];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        date.isSelected = !date.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            date.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: date.isSelected
                                ? AppTheme.getTheme().primaryColor
                                : Colors.grey.withOpacity(0.6),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            date.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          cout += 1;
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  Widget priceBarFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            S.of(context).priceFor1Night,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        RangeSliderWidget(
          values: _values,
          onChnageRangeValues: (values) {
            if (values != null) _values = values;
          },
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }

  // Widget getAppBarUI() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: AppTheme.getTheme().backgroundColor,
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(color: Colors.grey.withOpacity(0.2), offset: Offset(0, 2), blurRadius: 4.0),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 8, right: 8),
  //       child: Row(
  //         children: <Widget>[
  //           Container(
  //             alignment: Alignment.centerLeft,
  //             width: AppBar().preferredSize.height + 40,
  //             height: AppBar().preferredSize.height,
  //             child: Material(
  //               color: Colors.transparent,
  //               child: InkWell(
  //                 borderRadius: BorderRadius.all(
  //                   Radius.circular(32.0),
  //                 ),
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Icon(Icons.close),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: Center(
  //               child: Text(
  //                 "Filters",
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 22,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Container(
  //             width: AppBar().preferredSize.height + 40,
  //             height: AppBar().preferredSize.height,
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget appBar() {
    return Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: AppBar().preferredSize.height,
              child: Padding(
                padding: EdgeInsets.only(top: 8, left: 8),
                child: Container(
                  width: AppBar().preferredSize.height - 8,
                  height: AppBar().preferredSize.height - 8,
                  child: InkWell(
                    borderRadius: BorderRadius.all(
                      Radius.circular(32.0),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 24, bottom: 16),
              child: Text(
                S.of(context).filters,
                style: new TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
