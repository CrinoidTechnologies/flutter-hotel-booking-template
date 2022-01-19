import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motel/app/ui/color_helper.dart';
import 'package:motel/app/validators/signup_validator.dart';
import 'package:motel/generated/l10n.dart';
import 'package:motel/modules/_common/widget/round_corner_text_input_widget.dart';
import 'package:motel/modules/_common/widget/round_corners_button_widget.dart';
import 'package:motel/modules/authentication/domain/entities/signup_entity.dart';
import '../../../../app/ui/appTheme.dart';
import '../../../../main.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignupEntity _entity;
  String _signUpStatus = '';

  @override
  void initState() {
    super.initState();
    _entity = SignupEntity();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: AppTheme.getTheme().backgroundColor,
        body: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: appBar(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 24,
                              ),
                              Expanded(
                                child: getFTButton(),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                child: getFTButton(isFacebook: false),
                              ),
                              SizedBox(
                                width: 24,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          S.of(context).orLogInWithEmail,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.getTheme().disabledColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 16),
                        child: RoundCornerTextInputWidget(
                          inputTextKey: Key('txt_first_name'),
                          hintText: S.of(context).firstName,
                          onChange: (v) {
                            _entity.firstName = v;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 16),
                        child: RoundCornerTextInputWidget(
                          inputTextKey: Key('txt_last_name'),
                          hintText: S.of(context).lastName,
                          onChange: (v) {
                            _entity.lastName = v;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: RoundCornerTextInputWidget(
                          inputTextKey: Key('txt_email'),
                          hintText: S.of(context).yourEmail,
                          onChange: (v) {
                            _entity.email = v;
                          },
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 16),
                        child: RoundCornerTextInputWidget(
                          inputTextKey: Key('txt_password'),
                          hintText: S.of(context).password,
                          onChange: (v) {
                            _entity.password = v;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 24, right: 24, bottom: 8, top: 24),
                        child: RoundCornerButtonWidget(
                          buttonKey: Key('btn_signup'),
                          title: S.of(context).signUp,
                          bgColor: ColorHelper.primaryColor,
                          onTap: () {
                            setState(() {
                              _signUpStatus = SignupValidator(
                                      firstName: _entity.firstName,
                                      lastName: _entity.lastName,
                                      email: _entity.email,
                                      password: _entity.password)
                                  .validate();

                              if (_signUpStatus ==
                                  S.current.validationSuccessful)
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.TabScreen,
                                    (Route<dynamic> route) => false);
                            });
                          },
                        ),
                      ),
                      Text(
                        _signUpStatus.toString(),
                        key: Key('txt_error'),
                        style: TextStyle(color: ColorHelper.errorColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          S
                              .of(context)
                              .bySigningUpYouAgreedWithOurTermsOfnservicesAnd,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.getTheme().disabledColor,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            S.of(context).alreadyHaveAccount,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.getTheme().disabledColor,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                S.of(context).logIn,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.getTheme().primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 24,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getFTButton({bool isFacebook: true}) {
    return isFacebook
        ? RoundCornerButtonWidget(
            title: S.of(context).facebook,
            bgColor: ColorHelper.facebookColor,
            prefixIcon:
                Icon(FontAwesomeIcons.facebookF, size: 20, color: Colors.white),
          )
        : RoundCornerButtonWidget(
            title: S.of(context).twitter,
            bgColor: ColorHelper.twitterColor,
            prefixIcon:
                Icon(FontAwesomeIcons.twitter, size: 20, color: Colors.white),
          );
  }

  Widget appBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: AppBar().preferredSize.height,
          child: Padding(
            padding: EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: InkWell(
                borderRadius: BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4, left: 24),
          child: Text(
            S.of(context).signUp,
            style: new TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
