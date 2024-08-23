import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/common/widgets/metin_app_bar.dart';
import 'package:metin/core/common/widgets/metin_back_button.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_error_snack_bar.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/core/utils/timer_ticker.dart';
import 'package:metin/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:metin/features/auth/presentation/bloc/timer/timer_bloc.dart';
import 'package:metin/features/auth/presentation/widgets/otp_form.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';

class SignInVerificationScreen extends StatelessWidget {
  const SignInVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Creates the timer view - the timer bloc - and finally starts the timer
    return BlocProvider<TimerBloc>(
      create: (context) => TimerBloc(ticker: const Ticker())
        ..add(const TimerStarted(duration: 60)),
      child: PhoneVerificationView(),
    );
  }
}

class PhoneVerificationView extends StatelessWidget {
  PhoneVerificationView({Key? key}) : super(key: key);
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authBloc = context.read<AuthenticationBloc>();
    var profileBloc = context.read<ProfileBloc>();

    return Scaffold(
      appBar: const MetinAppBar(
        leading: MetinBackButton(),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: aHeight(13.5, context),
                ),
                //Verification text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: aHeight(6.5, context),
                            child: const TimerText(),
                          ),
                          SizedBox(height: aHeight(5, context)),
                          SizedBox(
                            height: aHeight(4.5, context),
                            child: AText(
                              text:
                                  'Type the verification code we\'ve sent you',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: aHeight(8, context)),

                // Form verification
                OtpForm(
                  controller1: controller1,
                  controller2: controller2,
                  controller3: controller3,
                  controller4: controller4,
                ),

                SizedBox(height: aHeight(8, context)),

                //Continue Button
                Center(
                  child: MetinButton(
                    text: 'Continue',
                    isBorder: false,
                    onPressed: () {
                      if (state is AuthenticationVerification) {
                        final String code =
                            "${controller1.text}${controller2.text}${controller3.text}${controller4.text}";
                        Map user = {};
                        if (state.loginType == LoginType.email) {
                          user = {
                            "loginType": LoginType.email,
                            "code": code,
                            "email": profileBloc.state.email
                          };
                        } else if (state.loginType == LoginType.phone) {
                          user = {
                            "loginType": LoginType.phone,
                            "code": code,
                            "country": profileBloc.state.country,
                            "phone": profileBloc.state.phone,
                            "phone_code": profileBloc.state.phoneCode
                          };
                        }
                        authBloc.add(
                          SignInVerificationEvent(
                            loginType: state.loginType,
                            user: user,
                            onSuccess: (user) {
                              if (user.user.name.isEmpty) {
                                profileBloc
                                    .add(ProfileIdChanged(id: user.user.id));
                                Navigator.of(context)
                                    .pushNamed('/main-profile-details');
                              } else {
                                Navigator.of(context).pushNamed('/home-screen');
                              }
                            },
                            onError: (e) {
                              showErrorMessage(context, e);
                            },
                          ),
                        );
                      }
                    },
                    color: Theme.of(context).primaryColor,
                    textStyle: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({Key? key}) : super(key: key);

  /// Returns the time based on the stream of the timer bloc.
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return AText(
      text: 'Verification $minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
