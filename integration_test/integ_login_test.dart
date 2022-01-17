import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/main.dart';
import 'package:motel/modules/authentication/preseentation/pages/login_page.dart';
import 'package:motel/modules/dashboard/presentation/pages/dashboard_page.dart';
import 'package:motel/modules/onBoadring/presentation/pages/introduction_screen.dart';

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

  testWidgets('Login attempt with empty email', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_login')));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);

    Finder emailInputTxt = find.byKey(Key('txt_email'));
    await tester.enterText(emailInputTxt, '');

    Finder passwordInputTxt = find.byKey(Key('txt_password'));
    await tester.enterText(passwordInputTxt, '@4Adddd');

    Finder loginButton = find.byKey(Key('btn_login'));
    await tester.tap(loginButton);

    await tester.pumpAndSettle();

    expect(find.text(S.current.pleaseEnterEmail), findsOneWidget);
  });

  testWidgets('Login attempt with empty password', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_login')));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);

    Finder emailInputTxt = find.byKey(Key('txt_email'));
    await tester.enterText(emailInputTxt, 'test@gmail.com');

    Finder passwordInputTxt = find.byKey(Key('txt_password'));
    await tester.enterText(passwordInputTxt, '');

    Finder loginButton = find.byKey(Key('btn_login'));
    await tester.tap(loginButton);

    await tester.pumpAndSettle();

    expect(find.text(S.current.pleaseEnterPassword), findsOneWidget);
  });

  testWidgets('Login attempt with invalid email', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_login')));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);

    Finder emailInputTxt = find.byKey(Key('txt_email'));
    await tester.enterText(emailInputTxt, 'test@gmail');

    Finder passwordInputTxt = find.byKey(Key('txt_password'));
    await tester.enterText(passwordInputTxt, '@4Adddd');

    Finder loginButton = find.byKey(Key('btn_login'));
    await tester.tap(loginButton);

    await tester.pumpAndSettle();

    expect(find.text(S.current.pleaseEnterValidEmail), findsOneWidget);
  });

  testWidgets('Login attempt with invalid password',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_login')));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);

    Finder emailInputTxt = find.byKey(Key('txt_email'));
    await tester.enterText(emailInputTxt, 'test@gmail.com');

    Finder passwordInputTxt = find.byKey(Key('txt_password'));
    await tester.enterText(passwordInputTxt, '@4Ad');

    Finder loginButton = find.byKey(Key('btn_login'));
    await tester.tap(loginButton);

    await tester.pumpAndSettle();

    expect(
        find.text(S.current.passwordMustBeWithIn620Characters), findsOneWidget);
  });

  testWidgets('Login attempt with valid credentials',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_login')));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);

    Finder emailInputTxt = find.byKey(Key('txt_email'));
    await tester.enterText(emailInputTxt, 'test@gmail.com');

    Finder passwordInputTxt = find.byKey(Key('txt_password'));
    await tester.enterText(passwordInputTxt, '@4Adssss');

    Finder loginButton = find.byKey(Key('btn_login'));
    await tester.tap(loginButton);

    await tester.pumpAndSettle();

    expect(find.byType(DashboardPage), findsOneWidget);
  });
}
