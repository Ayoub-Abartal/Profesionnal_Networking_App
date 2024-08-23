import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/common/widgets/metin_app_bar.dart';
import 'package:metin/core/common/widgets/metin_back_button.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_error_snack_bar.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';

/// The login and registration have the same field so no need to repeat them
/// or create other files to contain each individual component because
/// they are all only for this section of the project
/// doing that by using functions and organising them for every phase.
class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({Key? key}) : super(key: key);

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final PageController _pageController = PageController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _cPassController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileBloc>();
    var authBloc = context.read<AuthenticationBloc>();

    /// Returns a text field responsible for the email check.
    Widget emailCheckScreen() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: aHeight(13.5, context),
            ),
            loginText(),
            emailField(),
            SizedBox(
              height: aHeight(3, context),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: MetinButton(
                  text: 'Continue',
                  isBorder: false,
                  onPressed: () async {
                    if (_emailController.text.isNotEmpty) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                      authBloc.add(EmailExistenceCheckEvent(
                          email: _emailController.text,
                          onSuccess: (r) {
                            if (r) {
                              _pageController.animateToPage(1,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOutQuad);
                            } else {
                              _pageController.animateToPage(2,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOutQuad);
                            }
                          },
                          onError: (e) {
                            showErrorMessage(context, e);
                          }));
                      Navigator.of(context).pop();
                    } else {
                      showErrorMessage(
                          context, "Please enter a valid email address");
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  textStyle: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }

    /// Returns email + password fields for the login action.
    Widget loginScreen() {
      return SingleChildScrollView(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: aHeight(13.5, context),
                ),
                loginText(),
                emailField(),
                passwordField(),
                if (state is AuthenticationError)
                  Center(
                    child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
                SizedBox(
                  height: aHeight(3, context),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28.0),
                    child: MetinButton(
                      text: 'Continue',
                      isBorder: false,
                      onPressed: () {
                        authBloc.add(
                          EmailLoginEvent(
                            user: {
                              "username": _emailController.text,
                              "password": _passController.text
                            },
                            onSuccess: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/home-screen", (route) => false);
                            },
                            onError: (e) {
                              showErrorMessage(context, e);
                            },
                          ),
                        );
                        // Navigator.of(context).pushNamed('/home-screen');
                      },
                      color: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    /// Returns email + password + password confirmation for register action.
    Widget registrationScreen() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: aHeight(13.5, context),
            ),
            loginText(),
            emailField(),
            passwordField(),
            passwordField(isConfirmField: true),
            SizedBox(
              height: aHeight(3, context),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: MetinButton(
                  text: 'Continue',
                  isBorder: false,
                  onPressed: () {
                    if (_passController.text == _cPassController.text &&
                        _passController.text.isNotEmpty &&
                        _cPassController.text.isNotEmpty) {
                      profileBloc.add(ProfileEmailChanged(
                        email: _emailController.text,
                      ));
                      authBloc.add(
                        EmailRegistrationEvent(
                          user: {
                            "email": _emailController.text,
                            "password": _passController.text,
                            "password_confirmation": _cPassController.text
                          },
                          onSuccess: () {
                            // _profileBloc.add(ProfileIdChanged(
                            //     id: response["data"]["user"]["id"]));
                            Navigator.of(context)
                                .pushNamed('/sign-in-verification');
                          },
                          onError: (msg) {
                            showErrorMessage(context, msg);
                          },
                        ),
                      );
                    } else {
                      showErrorMessage(context, "Invalid password");
                    }
                  },
                  color: Theme.of(context).primaryColor,
                  textStyle: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: const MetinAppBar(
        leading: MetinBackButton(),
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            emailCheckScreen(),
            loginScreen(),
            registrationScreen(),
          ],
        ),
      ),
    );
  }

  /// Returns the title of the page.
  Widget loginText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Login with email Text
        SizedBox(
          height: aHeight(4.5, context),
          child: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: AText(
                text: 'Login With Email',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
          ),
        ),
        const SizedBox(
          height: 11,
        ),
      ],
    );
  }

  /// Returns the Email Text Field
  Widget emailField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
      child: SizedBox(
        width: 295.0,
        child: MetinTextField(
          controller: _emailController,
          onEditingComplete: () {
            FocusScope.of(context).unfocus();
          },
          isObscure: false,
          hintText: 'example@gmail.com',
          labelText: 'Email',
        ),
      ),
    );
  }

  /// Returns the password Text Field
  Widget passwordField({bool isConfirmField = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 8.0),
      child: SizedBox(
        width: 295.0,
        child: MetinTextField(
          controller: isConfirmField ? _cPassController : _passController,
          isObscure: true,
          hintText: '',
          labelText: isConfirmField ? 'Confirm password' : 'Password',
        ),
      ),
    );
  }
}
