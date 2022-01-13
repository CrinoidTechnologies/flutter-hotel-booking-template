import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motel/modules/dashboard/presentation/pages/dashboard_page.dart';
import 'app/ui/appTheme.dart';
import 'generated/l10n.dart';
import 'modules/onBoadring/presentation/pages/splash_screen.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
  // runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  static restartApp(BuildContext context) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;

    state.restartApp();
  }

  static setCustomeTheme(BuildContext context) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setCustomeTheme();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = new UniqueKey();

  void restartApp() {
    this.setState(() {
      navigatorKey = new GlobalKey<NavigatorState>();
      key = new UniqueKey();
    });
  }

  void setCustomeTheme() {
    setState(() {
      AppTheme.isDark = !AppTheme.isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          AppTheme.isDark ? Brightness.dark : Brightness.light,
      statusBarBrightness: AppTheme.isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: AppTheme.isDark ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness:
          AppTheme.isDark ? Brightness.dark : Brightness.light,
    ));
    return Container(
      key: key,
      color: AppTheme.getTheme().backgroundColor,
      child: MaterialApp(
          localizationsDelegates: [
            S.delegate,
          ],
          locale: Locale('en', 'US'),
          navigatorKey: navigatorKey,
          title: 'Motel',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.getTheme(),
          routes: routes,
          builder: (BuildContext context, Widget? child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: Builder(
                builder: (BuildContext context) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: MediaQuery.of(context).size.width > 360
                          ? 1.0
                          : MediaQuery.of(context).size.width >= 340
                              ? 0.9
                              : 0.8,
                    ),
                    child: child!,
                  );
                },
              ),
            );
          }),
    );
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashPage(),
    Routes.TabScreen: (BuildContext context) => new DashboardPage(),
  };
}

class Routes {
  static const String SPLASH = "/";
  static const String TabScreen = "/dashboard/dashboard_page";
}
