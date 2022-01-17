import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/main.dart';
import 'package:motel/modules/authentication/preseentation/pages/login_page.dart';
import 'package:motel/modules/authentication/preseentation/pages/signup_page.dart';
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

  testWidgets('Signup attempt with empty first name',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_create_acc')));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(find.byKey(Key('txt_last_name')), 'Last name');

    await tester.enterText(find.byKey(Key('txt_email')), 'test@gmail.com');

    await tester.enterText(find.byKey(Key('txt_password')), '@As4ffff');

    await tester.tap(find.byKey(Key('btn_signup')));

    await tester.pumpAndSettle();

    expect(find.text(S.current.pleaseEnterYourFirstName), findsOneWidget);
  });

  testWidgets('Signup attempt with empty last name',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_create_acc')));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(find.byKey(Key('txt_first_name')), 'First name');

    await tester.enterText(find.byKey(Key('txt_email')), 'test@gmail.com');

    await tester.enterText(find.byKey(Key('txt_password')), '@As4ffff');

    await tester.tap(find.byKey(Key('btn_signup')));

    await tester.pumpAndSettle();

    expect(find.text(S.current.pleaseEnterYourLastName), findsOneWidget);
  });

  testWidgets('Signup attempt with empty email', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_create_acc')));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(find.byKey(Key('txt_first_name')), 'First name');

    await tester.enterText(find.byKey(Key('txt_last_name')), 'Last name');

    await tester.enterText(find.byKey(Key('txt_password')), '@As4ffff');

    await tester.tap(find.byKey(Key('btn_signup')));

    await tester.pumpAndSettle();

    expect(find.text(S.current.pleaseEnterEmail), findsOneWidget);
  });

  testWidgets('Signup attempt with empty password',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_create_acc')));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(find.byKey(Key('txt_first_name')), 'First name');

    await tester.enterText(find.byKey(Key('txt_last_name')), 'Last name');

    await tester.enterText(find.byKey(Key('txt_email')), 'test@gmail.com');

    await tester.tap(find.byKey(Key('btn_signup')));

    await tester.pumpAndSettle();

    expect(find.text(S.current.pleaseEnterPassword), findsOneWidget);
  });

  testWidgets('Signup attempt with invalid email', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_create_acc')));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(find.byKey(Key('txt_first_name')), 'First name');

    await tester.enterText(find.byKey(Key('txt_last_name')), 'Last name');

    await tester.enterText(find.byKey(Key('txt_email')), 'test@gmail');

    await tester.enterText(find.byKey(Key('txt_password')), '@As4ffff');

    await tester.tap(find.byKey(Key('btn_signup')));

    await tester.pumpAndSettle();

    expect(find.text(S.current.pleaseEnterValidEmail), findsOneWidget);
  });

  testWidgets('Signup attempt with invalid password',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_create_acc')));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(find.byKey(Key('txt_first_name')), 'First name');

    await tester.enterText(find.byKey(Key('txt_last_name')), 'Last name');

    await tester.enterText(find.byKey(Key('txt_email')), 'test@gmail.com');

    await tester.enterText(find.byKey(Key('txt_password')), '@As4');

    await tester.tap(find.byKey(Key('btn_signup')));

    await tester.pumpAndSettle();

    expect(
        find.text(S.current.passwordMustBeWithIn620Characters), findsOneWidget);
  });

  
  testWidgets('Signup attempt with valid credentials',
      (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: MyApp(), locale: Locale('en', 'US')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(Key('txt_get_started')));
    await tester.pumpAndSettle();
    expect(find.byType(IntroductionPage), findsOneWidget);
    await tester.tap(find.byKey(Key('btn_create_acc')));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(find.byKey(Key('txt_first_name')), 'First name');

    await tester.enterText(find.byKey(Key('txt_last_name')), 'Last name');

    await tester.enterText(find.byKey(Key('txt_email')), 'test@gmail.com');

    await tester.enterText(find.byKey(Key('txt_password')), '@As4sssss');

    await tester.tap(find.byKey(Key('btn_signup')));

    await tester.pumpAndSettle();

    expect(find.byType(DashboardPage), findsOneWidget);
  });
}
