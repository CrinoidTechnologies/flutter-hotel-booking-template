import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:motel/app/validators/signup_validator.dart';
import 'package:motel/generated/l10n.dart';

void main() async {
  
  await S.load(Locale.fromSubtags(
      languageCode: 'en')); // mimic localization delegate init

  group('Signup validations test cases', () {
    test('Empty first name', () {
      expect(
          SignupValidator(
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: '@34ghbsc')
              .validate(),
          S.current.pleaseEnterYourFirstName);
    });
    test('Empty last name', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  email: 'test@gmail.com',
                  password: '@34ghbsc')
              .validate(),
          S.current.pleaseEnterYourLastName);
    });
    test('Empty email', () {
      expect(
          SignupValidator(
                  firstName: 'abc', lastName: 'xyz', password: '@34ghbsc')
              .validate(),
          S.current.pleaseEnterEmail);
    });
    test('Empty password', () {
      expect(
          SignupValidator(
            firstName: 'abc',
            lastName: 'xyz',
            email: 'test@gmail.com',
          ).validate(),
          S.current.pleaseEnterPassword);
    });
    test('Invalid email', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail',
                  password: '@34ghbsc')
              .validate(),
          S.current.pleaseEnterValidEmail);
    });
    test('Invalid password 01', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: '@34')
              .validate(),
          S.current.passwordMustBeWithIn620Characters);
    });
    test('Invalid password 02', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: '@34444')
              .validate(),
          S.current.passwordMustIncludeAtLeastOneUpperLowerCaseOne);
    });
    test('Invalid password 03', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: '@34bfg')
              .validate(),
          S.current.passwordMustIncludeAtLeastOneUpperLowerCaseOne);
    });
    test('Invalid password 04', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: '@Aassa')
              .validate(),
          S.current.passwordMustIncludeAtLeastOneUpperLowerCaseOne);
    });
    test('Successful validation', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: 'A@se2ee')
              .validate(),
          S.current.validationSuccessful);
    });
  });
}
