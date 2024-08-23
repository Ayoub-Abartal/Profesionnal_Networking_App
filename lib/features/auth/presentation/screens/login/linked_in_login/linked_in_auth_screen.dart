import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:metin/core/api/api.dart';
import 'package:metin/core/common/widgets/metin_app_bar.dart';
import 'package:metin/core/common/widgets/metin_back_button.dart';
import 'package:metin/core/common/widgets/metin_error_snack_bar.dart';

class LinkedInAuthScreen extends StatelessWidget {
  final Function(UserSucceededAction)? onGetUserProfile;
  final Function(String) onError;
  const LinkedInAuthScreen(
      {Key? key, required this.onError, this.onGetUserProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MetinAppBar(
        leading: MetinBackButton(),
      ),
      body: LinkedInUserWidget(
        redirectUrl: LinkedInOAuthApp.redirectUrl,
        clientId: LinkedInOAuthApp.clientId,
        clientSecret: LinkedInOAuthApp.clientSecret,
        onGetUserProfile: onGetUserProfile,
        onError: (UserFailedAction e) {
          showErrorMessage(context, "Please try again");
          Navigator.pop(context);
        },
      ),
    );
  }
}
