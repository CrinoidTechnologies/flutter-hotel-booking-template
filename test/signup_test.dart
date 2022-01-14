import 'package:flutter_test/flutter_test.dart';
import 'package:motel/app/validators/signup_validator.dart';

void main() {
  group('Signup validations test cases', () {
    test('Empty first name', () {
      expect(
          SignupValidator(
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: '@34ghbsc')
              .validate(),
          'Please enter your first name.');
    });
    test('Empty last name', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  email: 'test@gmail.com',
                  password: '@34ghbsc')
              .validate(),
          'Please enter your last name');
    });
    test('Empty email', () {
      expect(
          SignupValidator(
                  firstName: 'abc', lastName: 'xyz', password: '@34ghbsc')
              .validate(),
          'Please enter email.');
    });
    test('Empty password', () {
      expect(
          SignupValidator(
            firstName: 'abc',
            lastName: 'xyz',
            email: 'test@gmail.com',
          ).validate(),
          'Please enter password.');
    });
    test('Invalid email', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail',
                  password: '@34ghbsc')
              .validate(),
          'Please enter valid email.');
    });
    test('Invalid password 01', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: '@34')
              .validate(),
          'Password must be with in 6-20 characters.');
    });
    test('Invalid password 02', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: '@34444')
              .validate(),
          'Password must include at least one upper & lower case, one special character & one numeric digit.');
    });
    test('Invalid password 03', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: '@34bfg')
              .validate(),
          'Password must include at least one upper & lower case, one special character & one numeric digit.');
    });
    test('Invalid password 04', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: '@Aassa')
              .validate(),
          'Password must include at least one upper & lower case, one special character & one numeric digit.');
    });
    test('Successful validation', () {
      expect(
          SignupValidator(
                  firstName: 'abc',
                  lastName: 'xyz',
                  email: 'test@gmail.com',
                  password: 'A@se2ee')
              .validate(),
          'Validation successful.');
    });
  });
}
