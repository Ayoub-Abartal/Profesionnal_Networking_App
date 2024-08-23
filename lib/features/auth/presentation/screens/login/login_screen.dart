import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_error_snack_bar.dart';
import 'package:metin/core/common/widgets/metin_icon_button.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:metin/features/auth/presentation/screens/login/linked_in_login/linked_in_auth_screen.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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

    Widget buildAuthButtons(context) {
      return Column(
        children: [
          MetinButton(
            color: Theme.of(context).primaryColor,
            text: "Log in with email",
            textStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
            isBorder: false,
            onPressed: () {
              Navigator.of(context).pushNamed('/email-login');
            },
          ),
          SizedBox(
            height: aHeight(1.5, context),
          ),
          MetinButton(
            color: Colors.white,
            text: "Phone number",
            textStyle: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Theme.of(context).primaryColor),
            isBorder: true,
            onPressed: () {
              Navigator.of(context).pushNamed('/phone-login');
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: aHeight(1, context)),
            child: Row(
              children: const [
                Expanded(
                  child: Divider(
                    thickness: 1,
                    indent: 20.0,
                    endIndent: 60.0,
                  ),
                ),
                Text(""),
                Expanded(
                  child: Divider(
                    thickness: 1,
                    indent: 65.0,
                    endIndent: 20.0,
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MetinIconButton(
                icon: FontAwesomeIcons.facebookSquare,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  authBloc.add(
                    FacebookLoginEvent(
                      onSuccess: (user) {
                        profileBloc.add(ProfileIdChanged(id: user.user.id));
                        profileBloc.add(
                            ProfileFullNameChanged(fullName: user.user.name));
                        authBloc.add(
                          GetUserProfileEvent(
                            onSuccess: (profile) {
                              if (profile.birthday != DateTime(0001, 01, 01)) {
                                Navigator.of(context).pushNamed('/home-screen');
                              } else {
                                Navigator.of(context)
                                    .pushNamed('/main-profile-details');
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
                //Color(0xff2683E0) Colors.redAccent
                icon: FontAwesomeIcons.google,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  authBloc.add(GoogleLoginEvent(
                    onSuccess: (user) {
                      profileBloc.add(ProfileIdChanged(id: user.user.id));
                      profileBloc.add(
                          ProfileFullNameChanged(fullName: user.user.name));
                      authBloc.add(
                        GetUserProfileEvent(
                          onSuccess: (profile) {
                            if (profile.birthday != DateTime(0001, 01, 01)) {
                              Navigator.of(context).pushNamed('/home-screen');
                            } else {
                              Navigator.of(context)
                                  .pushNamed('/main-profile-details');
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
                //Color(0xff2683E0) Colors.black
                icon: FontAwesomeIcons.linkedin,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LinkedInAuthScreen(
                        onGetUserProfile: (UserSucceededAction linkedInUser) {
                          authBloc.add(LinkedInLoginEvent(
                            token:
                                linkedInUser.user.token.accessToken.toString(),
                            onSuccess: (user) {
                              profileBloc
                                  .add(ProfileIdChanged(id: user.user.id));
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
                                      Navigator.of(context)
                                          .pushNamed('/main-profile-details');
                                    }
                                  },
                                  onNotFound: (msg) {
                                    authBloc.add(
                                      RegisterProfileEvent(
                                        onSuccess: () {},
                                        onError: (msg) {},
                                      ),
                                    );
                                    Navigator.of(context)
                                        .pushNamed('/main-profile-details');
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
                        onError: (msg) => showErrorMessage(context, msg),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 2.0),
                    child: SizedBox(
                      height: aHeight(4, context),
                      child: AText(
                        text: "METIN",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: aHeight(18, context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: AText(
                        text: "Meet your\nBizz",
                        style: Theme.of(context).textTheme.headline1!,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: aHeight(2, context),
                  ),
                  Image(
                    height: aHeight(15, context),
                    width: 108.64,
                    image: const AssetImage('assets/images/metin_logo.png'),
                  ),
                  SizedBox(
                    height: aHeight(6, context),
                  ),
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is AuthenticationStateInitial) {
                        return buildAuthButtons(context);
                      } else if (state is AuthenticationLoading) {
                        return SizedBox(
                          height: aHeight(30, context),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      // else if (state is AuthenticationError) {
                      //   showErrorMessage(
                      //       context, "An error occurred, please try again");
                      //   return buildAuthButtons(context);
                      // }
                      else if (state is AuthenticationEnded ||
                          state is AuthenticationError ||
                          state is AuthenticationVerification) {
                        return buildAuthButtons(context);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  SizedBox(
                    height: aHeight(4, context),
                  ),
                  SizedBox(
                    height: aHeight(4, context),
                    child: Padding(
                      padding: EdgeInsets.all(aWidth(1, context)),
                      child: AText(
                        text: "By clicking login up, your agree with our ",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: aHeight(3, context),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: aWidth(10, context)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AText(
                          text: "Terms of uses",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Colors.blue)),
                      AText(
                        text: 'Privacy policy',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Colors.blue),
                      ),
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
}

class Preview extends StatelessWidget {
  const Preview({Key? key, required this.user}) : super(key: key);
  final GoogleSignInAccount user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              child: Image.network(user.photoUrl.toString()),
            ),
            Text(user.displayName.toString()),
            Text(user.email),
          ],
        ),
      ),
    );
  }
}

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}
