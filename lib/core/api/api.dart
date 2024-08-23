import 'dart:io' show Platform;

class MetinAPI {
  static String baseUrl = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  static String scheme = 'http';
  static int port = 8989;

  // ------------ Registration ------------
  static Uri registerUserEmail = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/user/auth/register/email',
  );
  static Uri registerUserPhone = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/user/auth/signinup/phone',
  );
  static Uri registerUserProfile = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/profile/',
  );
  static Uri registerUserFullName = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/user/user_id/name',
  );
  // --------------------------------------

  // ------------ Login with Auth provider ------------
  static Uri loginUserWithGoogle = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/user/auth/login/google',
  );
  static Uri loginUserWithFacebook = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/user/auth/login/Facebook',
  );
  static Uri loginUserWithLinkedIn = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/user/auth/login/linkedin',
  );
  // --------------------------------------------------

  // ------------ Login with email ------------
  static Uri loginUserWithEmail = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/user/auth/login/email',
  );
  static Uri checkUserExistence = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/user/search',
    queryParameters: {"email": ""},
  );
  // --------------------------------------

  // ------------ Auth verification ------------
  static Uri verifyUserEmail = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/user/auth/login/email/confirm',
  );
  static Uri verifyUserPhone = Uri(
    scheme: scheme,
    host: baseUrl,
    port: port,
    path: '/user/auth/login/phone/confirm',
  );
  // --------------------------------------

}

class LinkedInOAuthApp {
  static String redirectUrl =
      "https://www.linkedin.com/developers/tools/oauth/redirect";

  static String clientId = "78sgf0c439q3k1";

  static String clientSecret = "il9mEGsCghCyMFQJ";
}

class GoogleOAuthApp {
  static String clientId =
      "386040840530-hfvsu46a6ga6vfljnmji5vk9epqkgphc.apps.googleusercontent.com";
}
