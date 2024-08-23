import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:metin/core/common/widgets/metin_app_bar.dart';
import 'package:metin/core/common/widgets/metin_back_button.dart';
import 'package:metin/core/common/widgets/metin_button.dart';
import 'package:metin/core/common/widgets/metin_error_snack_bar.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/core/utils/adaptive_text.dart';
import 'package:metin/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:metin/features/user/profile%20details/presentation/bloc/profile/profile_bloc.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({Key? key}) : super(key: key);

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController controller = TextEditingController();
  CountryCode code = CountryCode(name: "Morocco", dialCode: "+212");
  Map userInput = {};

  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileBloc>();
    var authBloc = context.read<AuthenticationBloc>();

    return Scaffold(
      appBar: const MetinAppBar(
        leading: MetinBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: aHeight(13.5, context),
            ),
            //Login with phone number
            SizedBox(
              height: aHeight(5, context),
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: AText(
                  text: 'Login With Phone number',
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: aHeight(5, context),
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: AText(
                  text:
                      'Please enter your valid phone number. We will send \nyou a 4-digit code to verify your account.',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100.0,
                  child: CountryCodePicker(
                    initialSelection: "+212",
                    onChanged: (e) {
                      setState(() {
                        code = e;
                      });
                      profileBloc.add(ProfilePhoneCodeChanged(
                          phoneCode: int.parse(
                              e.dialCode.toString().replaceFirst('+', ''))));
                      profileBloc.add(
                          ProfileCountryChanged(country: e.name.toString()));
                    },
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(12.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(12.0)),
                      suffixIcon: IconButton(
                        onPressed: () => controller.clear(),
                        icon: const FaIcon(FontAwesomeIcons.xmark, size: 18.0),
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //Number field
            SizedBox(
              height: aHeight(15, context),
            ),
            //Continue Button
            Center(
              child: MetinButton(
                text: 'Continue',
                isBorder: false,
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    profileBloc
                        .add(ProfilePhoneChanged(phone: controller.text));
                    setState(() {
                      userInput = {
                        "phone_code":
                            int.parse(code.dialCode!.replaceFirst("+", '')),
                        "country": code.name.toString(),
                        "phone": controller.text
                      };
                    });

                    authBloc.add(PhoneRegistrationEvent(
                        user: userInput,
                        onSuccess: (r) {
                          Navigator.of(context)
                              .pushNamed('/sign-in-verification');
                        },
                        onError: (e) {
                          showErrorMessage(context, e);
                        }));
                  } else {
                    showErrorMessage(
                        context, "Please enter a valid phone number");
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
        ),
      ),
    );
  }
}
