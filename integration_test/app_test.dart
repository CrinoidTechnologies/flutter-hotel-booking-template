import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/main.dart' as app;
import 'package:motel/modules/authentication/preseentation/pages/login_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Widget makeTestableWidget({required Widget child, required Locale locale}) {
    return MaterialApp(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: locale,
      home: child,
    );
  }

  group('end-to-end test', () {
    testWidgets('Login attempt with invalid email',
        (WidgetTester tester) async {
      // app.main();

      Widget loginPage = makeTestableWidget(child: LoginPage(), locale: Locale('en', 'US'));

      // await tester.pumpAndSettle();
      await tester.pumpWidget(loginPage);

      Finder emailInputTxt = find.byKey(new Key('txt_email'));
      await tester.enterText(emailInputTxt, 'test@gmail');

      Finder passwordInputTxt = find.byKey(new Key('txt_password'));
      await tester.enterText(passwordInputTxt, '@4Adddd');

      Finder loginButton = find.byKey(new Key('btn_login'));
      await tester.tap(loginButton);

      await tester.pump();

      Finder txtLogin = find.byKey(new Key('txt_login'));
      expect(txtLogin.toString(), 'false');
    });
  });
}
