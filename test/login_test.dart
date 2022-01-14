import 'package:flutter_test/flutter_test.dart';
import 'package:motel/app/validators/login_validator.dart';

void main() {
  group('Login validations test cases', () {
    test('Empty email', () {
      expect(LoginValidator(password: '@34ghbsc').validate(),
          'Please enter email.');
    });
    test('Empty password', () {
      expect(LoginValidator(email: 'test@gmail.com').validate(),
          'Please enter password.');
    });
    test('Invalid email', () {
      expect(
          LoginValidator(email: 'test@gmail', password: '@aA9hdd').validate(),
          'Please enter valid email.');
    });
    test('Invalid password', () {
      expect(
          LoginValidator(email: 'test@gmail.com', password: 'ww3r').validate(),
          'Password must be with in 6-20 characters.');
    });
    test('Validation successful.', () {
      expect(
          LoginValidator(email: 'test@gmail.com', password: '@aA9hdd')
              .validate(),
          'Validation successful.');
    });
  });
}
