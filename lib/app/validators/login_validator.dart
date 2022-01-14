class LoginValidator {
  String? email;
  String? password;

  LoginValidator({this.email, this.password});

  String validate() {
    String value = 'Validation successful.';

    if ((email ?? '').isEmpty) {
      value = 'Please enter email.';
    } else if ((password ?? '').isEmpty) {
      value = 'Please enter password.';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email!)) {
      value = 'Please enter valid email.';
    } else if (password!.length < 6 || password!.length > 20) {
      value = 'Password must be with in 6-20 characters.';
    }

    return value;
  }
}
