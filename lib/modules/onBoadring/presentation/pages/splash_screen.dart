import 'package:flutter/material.dart';
import 'package:motel/generated/l10n.dart';
import 'introduction_screen.dart';
import '../../../../app/ui/appTheme.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              foregroundDecoration: !AppTheme.isDark
                  ? BoxDecoration(
                      color:
                          AppTheme.getTheme().backgroundColor.withOpacity(0.4))
                  : null,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/images/introduction.jpg',
                  fit: BoxFit.cover),
            ),
            Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Center(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: AppTheme.getTheme().dividerColor,
                            offset: Offset(1.1, 1.1),
                            blurRadius: 10.0),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      child: Image.asset('assets/images/appIcon.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  S.of(context).motel,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  S.of(context).bestHotelDealsForYourHoliday,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SizedBox(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 48, right: 48, bottom: 8, top: 8),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IntroductionPage()),
                        );
                      },
                      child: Center(
                        child: Text(
                          S.of(context).getStarted,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: 24.0 + MediaQuery.of(context).padding.bottom,
                      top: 16),
                  child: Text(
                    S.of(context).alreadyHaveAccountLogIn,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
