import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../main.dart';
import '../../domain/entities/setting_entity.dart';
import 'country_list_page.dart';
import 'currency_list_page.dart';
import '../../../../app/ui/appTheme.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<SettingEntity> settingsList = SettingEntity.settingsList;
  var country = 'Australia';
  var currency = '\$ AUD';

  @override
  Widget build(BuildContext context) {
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
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, bottom: 24),
              child: appBar(),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: settingsList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 6) {
                        MyApp.restartApp(context);
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CurrencyListPage(),
                            fullscreenDialog: true,
                          ),
                        ).then((value) {
                          if (value is String) {
                            if (value != "") {
                              setState(() {
                                currency = value;
                              });
                            }
                          }
                        });
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountryListPage(),
                            fullscreenDialog: true,
                          ),
                        ).then((value) {
                          if (value is String) {
                            if (value != "") {
                              setState(() {
                                country = value;
                              });
                            }
                          }
                        });
                      }
                    },
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
                                    settingsList[index].titleTxt!,
                                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                                  ),
                                ),
                              ),
                              index == 1
                                  ? Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Container(
                                        child: Text(
                                          country,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppTheme.getTheme().disabledColor.withOpacity(0.3),
                                          ),
                                        ),
                                      ),
                                    )
                                  : index == 2
                                      ? Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Container(
                                            child: Text(
                                              currency,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: AppTheme.getTheme().disabledColor.withOpacity(0.3),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Container(
                                            child:
                                                Icon(settingsList[index].iconData, color: AppTheme.getTheme().disabledColor.withOpacity(0.3)),
                                          ),
                                        )
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: AppBar().preferredSize.height,
              child: Padding(
                padding: EdgeInsets.only(top: 8, right: 8),
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
                        
                        MyApp.setCustomeTheme(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(AppTheme.isDark ? FontAwesomeIcons.cloudSun : FontAwesomeIcons.cloudMoon),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 24),
          child: Text(
            "Settings",
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
