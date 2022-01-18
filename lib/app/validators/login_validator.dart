import 'package:motel/generated/l10n.dart';

class LoginValidator {
  String? email;
  String? password;

  LoginValidator({this.email, this.password});

  String validate() {
    String value = S.current.validationSuccessful;
    if ((email ?? '').isEmpty) {
      value = S.current.pleaseEnterEmail;
    } else if ((password ?? '').isEmpty) {
      value = S.current.pleaseEnterPassword;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!)) {
      value = S.current.pleaseEnterValidEmail;
    } else if (password!.length < 6 || password!.length > 20) {
      value = S.current.passwordMustBeWithIn620Characters;
    }
    return value;
  }
}
