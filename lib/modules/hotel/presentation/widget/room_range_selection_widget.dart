import 'package:flutter/material.dart';
import 'package:motel/generated/l10n.dart';
import '../../../../app/ui/appTheme.dart';

class RoomRangeSelectionWidget extends StatefulWidget {
  final Function(int, int, int)? onChnage;
  final bool? barrierDismissible;
  final int? room;
  final int? ad;
  final int? ch;

  const RoomRangeSelectionWidget(
      {Key? key,
      this.barrierDismissible,
      this.room,
      this.ad,
      this.ch,
      this.onChnage})
      : super(key: key);

  @override
  _RoomRangeSelectionWidgetState createState() =>
      _RoomRangeSelectionWidgetState();
}

class _RoomRangeSelectionWidgetState extends State<RoomRangeSelectionWidget>
    with TickerProviderStateMixin {
  PopupTextType popupTextType = PopupTextType.no;
  late AnimationController animationController;
  int room = 1;
  int ad = 2;
  int ch = 0;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    room = widget.room ?? 0;
    ad = widget.ad ?? 0;
    ch = widget.ch ?? 0;
    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) {
            return AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: animationController.value,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (widget.barrierDismissible!) {
                    Navigator.pop(context);
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.getTheme().backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.getTheme().dividerColor,
                              offset: Offset(4, 4),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            getRowView(
                                "Number of Rooms", "", room, PopupTextType.no),
                            getRowView(
                                "Adult", " (Aged 18+)", ad, PopupTextType.ad),
                            getRowView(
                                "Children", " (0-17)", ch, PopupTextType.ch),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16, top: 24),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppTheme.getTheme().primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: AppTheme.getTheme().dividerColor,
                                      blurRadius: 8,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24.0)),
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      try {
                                        widget.onChnage!(room, ad, ch);
                                        Navigator.pop(context);
                                      } catch (e) {}
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
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget getRowView(
      String txt, String subtxt, int count, PopupTextType popupTextType) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    txt,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    subtxt,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color:
                                            AppTheme.getTheme().disabledColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(32.0),
                              onTap: () {
                                setState(() {
                                  if (popupTextType == PopupTextType.no) {
                                    room += 1;
                                  } else if (popupTextType ==
                                      PopupTextType.ad) {
                                    ad += 1;
                                  } else {
                                    ch += 1;
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.add_circle_outline,
                                  size: 28,
                                  color: AppTheme.getTheme().disabledColor,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "  $count  ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(32.0),
                              onTap: () {
                                setState(() {
                                  if (popupTextType == PopupTextType.no) {
                                    room -= 1;
                                    if (room < 0) {
                                      room = 0;
                                    }
                                  } else if (popupTextType ==
                                      PopupTextType.ad) {
                                    ad -= 1;
                                    if (ad < 0) {
                                      ad = 0;
                                    }
                                  } else {
                                    ch -= 1;
                                    if (ch < 0) {
                                      ch = 0;
                                    }
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.remove_circle_outline,
                                  size: 28,
                                  color: AppTheme.getTheme().disabledColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}

enum PopupTextType { no, ad, ch }
