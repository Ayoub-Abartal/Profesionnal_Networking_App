import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_error_snack_bar.dart';
import 'package:metin/core/common/widgets/metin_icon_button.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';

import 'linked_in_login/linked_in_auth_screen.dart';

class NewLoginScreen extends StatefulWidget {
  const NewLoginScreen({Key? key}) : super(key: key);

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late PageController _pageController;

  double pageState = 0.0;

  bool rememberMe = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = context.read<AuthenticationBloc>();
    var profileBloc = context.read<ProfileBloc>();

    void onUserNotFound() {
      authBloc.add(
        RegisterProfileEvent(
          onSuccess: () {},
          onError: (msg) {},
        ),
      );
      Navigator.of(context).pushNamed('/main-profile-details');
    }

    return Scaffold(
      body: SizedBox(
        height: aHeight(100, context),
        width: aWidth(100, context),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: 180,
              child: CircleAvatar(
                radius: aHeight(24, context),
                backgroundColor: const Color(0xffAAF3F3).withOpacity(0.22),
              ),
            ),
            Positioned(
              top: 170,
              left: -160,
              child: CircleAvatar(
                radius: aHeight(18, context),
                backgroundColor: const Color(0xffFE8668).withOpacity(0.1),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: aHeight(18, context)),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Text(
                      "Comate",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Text(
                      "Meet the right person",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: aWidth(100, context),
                height: aHeight(65, context),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: aWidth(10, context),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: aHeight(6, context)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 9.0),
                                      child: Text(
                                        "Welcome To Comate",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                      ),
                                    ),
                                    Text(
                                      "Sign in to continue",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // This place where we handle the email and the password
                          SizedBox(
                            height:
                                aHeight(pageState == 0 ? 18.5 : 29, context),
                            child: PageView(
                              controller: _pageController,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: aHeight(5, context),
                                  ),
                                  child: MetinTextField(
                                    controller: _emailController,
                                    hintText: "Email or phone number",
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: aHeight(5, context),
                                  ),
                                  child: Column(
                                    children: [
                                      MetinTextField(
                                        controller: _emailController,
                                        isRoundedDesign: false,
                                        hintText: "Email or phone number",
                                      ),
                                      MetinTextField(
                                        controller: _passwordController,
                                        isObscure: true,
                                        isRoundedDesign: false,
                                        hintText: "Password",
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                  value: rememberMe,
                                                  onChanged: (v) {
                                                    setState(() {
                                                      rememberMe = v!;
                                                    });
                                                  }),
                                              Text(
                                                "Remember me",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .copyWith(
                                                      fontSize: 13,
                                                    ),
                                              ),
                                            ],
                                          ),
                                          GestureDetector(
                                            child: Text(
                                              "Forgot password?",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                    fontSize: 13,
                                                    color: const Color(
                                                      0xff2567A4,
                                                    ),
                                                  ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: aHeight(3.5, context)),
                            child: MetinButton(
                              text: "SIGN IN",
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                              borderRadius: 72,
                              elevation: 10,
                              isBorder: false,
                              onPressed: () {
                                if (pageState == 0.0) {
                                  if (_emailController.text.isNotEmpty) {
                                    authBloc.add(
                                      EmailExistenceCheckEvent(
                                        email: _emailController.text,
                                        onSuccess: (r) {
                                          if (r) {
                                            setState(() {
                                              pageState = 1.0;
                                              _pageController.nextPage(
                                                  duration: const Duration(
                                                      microseconds: 800),
                                                  curve: Curves.easeIn);
                                            });
                                          } else {
                                            showErrorMessage(context,
                                                "No account with this email address");
                                          }
                                        },
                                        onError: (e) {
                                          showErrorMessage(context, e);
                                        },
                                      ),
                                    );
                                  } else {
                                    showErrorMessage(context,
                                        "Please enter a valid email address");
                                  }
                                } else {
                                  authBloc.add(
                                    EmailLoginEvent(
                                      user: {
                                        "username": _emailController.text,
                                        "password": _passwordController.text
                                      },
                                      onSuccess: () {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            "/home-screen",
                                            (route) => false);
                                      },
                                      onError: (e) {
                                        showErrorMessage(context, e);
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          if (pageState == 0)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: aHeight(3, context),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: aWidth(18, context),
                                    child: const Divider(
                                      color: Color(0xffC4C4C4),
                                      thickness: 0.5,
                                    ),
                                  ),
                                  Text(
                                    "or continue with",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                  SizedBox(
                                    width: aWidth(18, context),
                                    child: const Divider(
                                      color: Color(0xffC4C4C4),
                                      thickness: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (pageState == 0)
                      Padding(
                        padding: EdgeInsets.only(bottom: aHeight(2, context)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MetinIconButton(
                              icon: FontAwesomeIcons.google,
                              iconSize: aHeight(3, context),
                              iconColor: Theme.of(context).primaryColor,
                              width: aWidth(25, context),
                              height: aHeight(8, context),
                              onPressed: () {
                                authBloc.add(GoogleLoginEvent(
                                  onSuccess: (user) {
                                    profileBloc.add(
                                        ProfileIdChanged(id: user.user.id));
                                    profileBloc.add(ProfileFullNameChanged(
                                        fullName: user.user.name));
                                    authBloc.add(
                                      GetUserProfileEvent(
                                        onSuccess: (profile) {
                                          if (profile.birthday !=
                                              DateTime(0001, 01, 01)) {
                                            Navigator.of(context)
                                                .pushNamed('/home-screen');
                                          } else {
                                            Navigator.of(context).pushNamed(
                                                '/main-profile-details');
                                          }
                                        },
                                        onNotFound: (msg) {
                                          onUserNotFound();
                                        },
                                      ),
                                    );
                                  },
                                  onError: (msg) {
                                    showErrorMessage(context, msg);
                                  },
                                ));
                              },
                            ),
                            MetinIconButton(
                              icon: FontAwesomeIcons.facebook,
                              iconSize: aHeight(3, context),
                              iconColor: Theme.of(context).primaryColor,
                              width: aWidth(25, context),
                              height: aHeight(8, context),
                              onPressed: () {
                                authBloc.add(
                                  FacebookLoginEvent(
                                    onSuccess: (user) {
                                      profileBloc.add(
                                          ProfileIdChanged(id: user.user.id));
                                      profileBloc.add(ProfileFullNameChanged(
                                          fullName: user.user.name));
                                      authBloc.add(
                                        GetUserProfileEvent(
                                          onSuccess: (profile) {
                                            if (profile.birthday !=
                                                DateTime(0001, 01, 01)) {
                                              Navigator.of(context)
                                                  .pushNamed('/home-screen');
                                            } else {
                                              Navigator.of(context).pushNamed(
                                                  '/main-profile-details');
                                            }
                                          },
                                          onNotFound: (msg) {
                                            onUserNotFound();
                                          },
                                        ),
                                      );
                                    },
                                    onError: (msg) {
                                      showErrorMessage(context, msg);
                                    },
                                  ),
                                );
                              },
                            ),
                            MetinIconButton(
                              icon: FontAwesomeIcons.linkedin,
                              iconSize: aHeight(3, context),
                              iconColor: Theme.of(context).primaryColor,
                              width: aWidth(25, context),
                              height: aHeight(8, context),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => LinkedInAuthScreen(
                                      onGetUserProfile:
                                          (UserSucceededAction linkedInUser) {
                                        authBloc.add(LinkedInLoginEvent(
                                          token: linkedInUser
                                              .user.token.accessToken
                                              .toString(),
                                          onSuccess: (user) {
                                            profileBloc.add(ProfileIdChanged(
                                                id: user.user.id));
                                            profileBloc.add(
                                                ProfileFullNameChanged(
                                                    fullName: user.user.name));
                                            authBloc.add(
                                              GetUserProfileEvent(
                                                onSuccess: (profile) {
                                                  if (profile.birthday !=
                                                      DateTime(0001, 01, 01)) {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                            '/home-screen');
                                                  } else {
                                                    Navigator.of(context).pushNamed(
                                                        '/main-profile-details');
                                                  }
                                                },
                                                onNotFound: (msg) {
                                                  authBloc.add(
                                                    RegisterProfileEvent(
                                                      onSuccess: () {},
                                                      onError: (msg) {},
                                                    ),
                                                  );
                                                  Navigator.of(context).pushNamed(
                                                      '/main-profile-details');
                                                },
                                              ),
                                            );
                                          },
                                          onError: (msg) {
                                            showErrorMessage(context, msg);
                                          },
                                        ));
                                        Navigator.of(context).pop();
                                      },
                                      onError: (msg) =>
                                          showErrorMessage(context, msg),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    //I Accept Terms of Use & Privacy Policy
                    RichText(
                      text: TextSpan(
                        text: "I Accept ",
                        style: Theme.of(context).textTheme.subtitle2,
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Terms of Use',
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                          TextSpan(
                            text: ' & ',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
