import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../app/ui/appTheme.dart';
import '../../../settings/domain/entities/setting_entity.dart';
import 'feedback_page.dart';

class HelpCenterPage extends StatefulWidget {
  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    List<SettingEntity> helpSearchList = SettingEntity.helpSearchList;
    return Scaffold(
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
            Container(
              color: AppTheme.getTheme().primaryColor,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 24),
                child: appBar(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                itemCount: helpSearchList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: helpSearchList[index].subTxt != ""
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FeedbackPage(
                                  title: helpSearchList[index].subTxt,
                                ),
                              ),
                            );
                          }
                        : null,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    helpSearchList[index].titleTxt != "" ? helpSearchList[index].titleTxt! : helpSearchList[index].subTxt!,
                                    style: TextStyle(
                                        fontWeight: helpSearchList[index].titleTxt != "" ? FontWeight.bold : FontWeight.normal,
                                        fontSize: helpSearchList[index].titleTxt != "" ? 18 : 14),
                                  ),
                                ),
                              ),
                              helpSearchList[index].subTxt != ""
                                  ? Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Container(
                                        child: Icon(Icons.keyboard_arrow_right, color: AppTheme.getTheme().disabledColor.withOpacity(0.3)),
                                      ),
                                    )
                                  : SizedBox()
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Divider(
                            height: 1,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
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
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back, color: AppTheme.getTheme().backgroundColor),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 24),
          child: Text(
            "How can we help?",
            style: new TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppTheme.getTheme().backgroundColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.getTheme().backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(38)),
              // border: Border.all(
              //   color: HexColor("#757575").withOpacity(0.6),
              // ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppTheme.getTheme().dividerColor,
                  blurRadius: 8,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Container(
                height: 48,
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.search,
                        size: 18,
                        color: AppTheme.getTheme().primaryColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          maxLines: 1,
                          onChanged: (String txt) {},
                          style: TextStyle(
                            fontSize: 16,
                            // color: AppTheme.dark_grey,
                          ),
                          cursorColor: AppTheme.getTheme().primaryColor,
                          decoration: new InputDecoration(
                            errorText: null,
                            border: InputBorder.none,
                            hintText: "Search help articales",
                            hintStyle: TextStyle(color: AppTheme.getTheme().disabledColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
