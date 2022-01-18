import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:motel/app/validators/login_validator.dart';
import 'package:motel/generated/l10n.dart';

void main() async {
  await S.load(Locale.fromSubtags(
      languageCode: 'en')); // mimic localization delegate init

  group('Login validations test cases', () {
    test('Empty email', () {
      expect(LoginValidator(password: '@34ghbsc').validate(),
          S.current.pleaseEnterEmail);
    });
    test('Empty password', () {
      expect(LoginValidator(email: 'test@gmail.com').validate(),
          S.current.pleaseEnterPassword);
    });
    test('Invalid email', () {
      expect(
          LoginValidator(email: 'test@gmail', password: '@aA9hdd').validate(),
          S.current.pleaseEnterValidEmail);
    });
    test('Invalid password', () {
      expect(
          LoginValidator(email: 'test@gmail.com', password: 'ww3r').validate(),
          S.current.passwordMustBeWithIn620Characters);
    });
    test('Validation successful.', () {
      expect(
          LoginValidator(email: 'test@gmail.com', password: '@aA9hdd')
              .validate(),
          S.current.validationSuccessful);
    });
  });
}
