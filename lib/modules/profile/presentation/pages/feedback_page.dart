import 'package:flutter/material.dart';
import '../../../../app/ui/appTheme.dart';
import '../../../settings/domain/entities/setting_entity.dart';

class FeedbackPage extends StatefulWidget {
  final String? title;

  const FeedbackPage({Key? key, this.title = ""}) : super(key: key);
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<SettingEntity> subHelpList = SettingEntity.subHelpList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: AppTheme.getTheme().backgroundColor,
        body: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 24),
                child: appBar(),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 16 + MediaQuery.of(context).padding.bottom),
                  itemCount: subHelpList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: subHelpList[index].isSelected ? () {} : null,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: subHelpList[index].titleTxt != ""
                                      ? Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            subHelpList[index].titleTxt!,
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(left: 16,right: 16,top: 8,bottom: 16),
                                          child: Container(
                                            child: Text(
                                              subHelpList[index].subTxt!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: subHelpList[index].isSelected
                                                    ? AppTheme.getTheme().primaryColor
                                                    : AppTheme.getTheme().disabledColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          subHelpList[index].isSelected
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 16, right: 16),
                                  child: Divider(
                                    height: 1,
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Column(
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
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 24, bottom: 24),
          child: Text(
            widget.title!,
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 24,
            left: 24,
          ),
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
}
