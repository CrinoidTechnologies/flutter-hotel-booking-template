import 'package:motel/generated/l10n.dart';

class SignupValidator {
  String? firstName;
  String? lastName;
  String? email;
  String? password;

  SignupValidator({this.firstName, this.lastName, this.email, this.password});

  String validate() {
    String value = 'Validation successful.';

    if ((firstName ?? '').isEmpty) {
      value = 'Please enter your first name.';
    } else if ((lastName ?? '').isEmpty) {
      value = 'Please enter your last name';
    } else if ((email ?? '').isEmpty) {
      value = 'Please enter email.';
    } else if ((password ?? '').isEmpty) {
      value = 'Please enter password.';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!)) {
      value = 'Please enter valid email.';
    } else if (password!.length < 6 || password!.length > 20) {
      value = 'Password must be with in 6-20 characters.';
    } else if (!RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@\$%^&*-]).{6,}\$")
        .hasMatch(password!)) {
      value = 'Password must include at least one upper & lower case, one special character & one numeric digit.';
    }

    return value;
  }
}
