import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motel/generated/l10n.dart';
import '../../../../app/ui/appTheme.dart';
import 'custom_calendar_widget.dart';

class CalendarPopupWidget extends StatefulWidget {
  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final bool barrierDismissible;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final Function(DateTime?, DateTime?)? onApplyClick;
  final Function? onCancelClick;

  const CalendarPopupWidget(
      {Key? key,
      this.initialStartDate,
      this.initialEndDate,
      this.onApplyClick,
      this.onCancelClick,
      this.barrierDismissible = true,
      this.minimumDate,
      this.maximumDate})
      : super(key: key);

  @override
  _CalendarPopupWidgetState createState() => _CalendarPopupWidgetState();
}

class _CalendarPopupWidgetState extends State<CalendarPopupWidget>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
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
        backgroundColor: AppTheme.isDark
            ? Colors.transparent
            : AppTheme.getTheme().backgroundColor.withOpacity(0.6),
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
                  if (widget.barrierDismissible) Navigator.pop(context);
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
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        S.of(context).from,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100,
                                            fontSize: 16,
                                            color:
                                                Colors.grey.withOpacity(0.8)),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        startDate != null
                                            ? DateFormat("EEE, dd MMM")
                                                .format(startDate!)
                                            : "--/-- ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 74,
                                  width: 1,
                                  color: AppTheme.getTheme().dividerColor,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        S.of(context).to,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100,
                                            fontSize: 16,
                                            color:
                                                Colors.grey.withOpacity(0.8)),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        endDate != null
                                            ? DateFormat("EEE, dd MMM")
                                                .format(endDate!)
                                            : "--/-- ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              height: 1,
                            ),
                            CustomCalendarWidget(
                              minimumDate: widget.minimumDate,
                              maximumDate: widget.maximumDate,
                              initialEndDate: widget.initialEndDate,
                              initialStartDate: widget.initialStartDate,
                              startEndDateChange: (DateTime? startDateData,
                                  DateTime? endDateData) {
                                setState(() {
                                  startDate = startDateData;
                                  endDate = endDateData;
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 16, top: 8),
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
                                child: InkWell(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)),
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    try {
                                      // animationController.reverse().then((f) {

                                      // });
                                      widget.onApplyClick!(
                                          startDate, endDate);
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
}
