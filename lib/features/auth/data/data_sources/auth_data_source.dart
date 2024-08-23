import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:metin/core/api/api.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/errors/exceptions.dart';
import 'package:metin/features/auth/data/models/profile_model.dart';
import 'package:metin/features/auth/data/models/user_model.dart';

abstract class AuthenticationDataSource {
  // Check the return type
  Future<bool> checkUserExistenceEmail(String email);
  Future<bool> registerEmail(Map user);
  Future<bool> registerPhone(Map user);
  Future<UserModel> verifySignIn(Map user);

  Future<UserModel> loginEmail(Map user);
  Future<UserModel> loginGoogle();
  Future<UserModel> loginFacebook();
  Future<UserModel> loginLinkedIn(String token);

  Future<bool> registerFullName(Map name);
  Future<ProfileModel> registerProfile(Map info);
  Future<ProfileModel> updateProfile(Map info);

  Future<ProfileModel> getUserProfile(String token);
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  Future<UserModel> _getUserFromUrl(
    Uri url,
    Map data,
    Map<String, String> headers, {
    bool shouldJSONEncode = true,
  }) async {
    final response = await http.post(url,
        body: shouldJSONEncode ? json.encode(data) : data, headers: headers);
    final decodedResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      final user = UserModel.fromJson(decodedResponse);
      return user;
    } else if (response.statusCode == 403) {
      throw AuthenticationException(msg: decodedResponse['detail'].toString());
    } else {
      throw ServerException(
          msg: decodedResponse['detail'][0]['msg'].toString());
    }
  }

  @override
  Future<UserModel> loginEmail(Map<dynamic, dynamic> credentials) {
    Map body = {
      "username": credentials['username'],
      "password": credentials['password'],
    };
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
      "accept": "application/json",
    };

    final url = MetinAPI.loginUserWithEmail;

    return _getUserFromUrl(
      url,
      body,
      headers,
      shouldJSONEncode: false,
    );
  }

  @override
  Future<UserModel> loginGoogle() async {
    GoogleSignIn googleSignIn = Platform.isIOS
        ? GoogleSignIn(clientId: GoogleOAuthApp.clientId)
        : GoogleSignIn();

    GoogleSignInAccount? userAccount = await googleSignIn.signIn();

    if (userAccount == null) {
      throw const AuthenticationException(
          msg: "Unable to login with google, it may be the user canceled");
    }
    final authentication = await userAccount.authentication;

    Map data = {"g_access_token": authentication.accessToken};
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "accept": "application/json",
    };
    final url = MetinAPI.loginUserWithGoogle;

    return _getUserFromUrl(url, data, headers);
  }

  @override
  Future<UserModel> loginFacebook() async {
    AccessToken? accessToken = await FacebookAuth.instance.accessToken;

    if (accessToken != null) {
    } else {
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status == LoginStatus.success) {
        accessToken = result.accessToken;
      } else {}
    }
    if (accessToken == null) {
      throw const AuthenticationException(
          msg: "Unable to login with google, it may be the user canceled");
    }
    Map data = {"fb_access_token": accessToken.token};
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "accept": "application/json",
    };
    final url = MetinAPI.loginUserWithFacebook;

    return _getUserFromUrl(url, data, headers);
  }

  @override
  Future<UserModel> loginLinkedIn(String token) {
    Map data = {"li_access_token": token};

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "accept": "application/json",
    };

    final url = MetinAPI.loginUserWithLinkedIn;

    return _getUserFromUrl(url, data, headers);
  }

  @override
  Future<bool> registerEmail(Map user) async {
    Map data = {
      "email": user['email'],
      "password": user['password'],
      "password_confirmation": user['password_confirmation'],
    };
    final url = MetinAPI.registerUserEmail;
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "accept": "application/json",
    };

    final response =
        await http.post(url, body: json.encode(data), headers: headers);
    final decodedResponse = json.decode(response.body);
    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 403) {
      throw AuthenticationException(msg: decodedResponse['detail'].toString());
    } else {
      throw ServerException(
          msg: decodedResponse['detail'][0]['msg'].toString());
    }
  }

  @override
  Future<bool> registerPhone(Map user) async {
    Map data = {
      "phone_code": {
        "phone_code": user["phone_code"],
        "country": user["country"]
      },
      "phone": user["phone"]
    };

    final url = MetinAPI.registerUserPhone;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "accept": "application/json",
    };

    final response =
        await http.post(url, body: json.encode(data), headers: headers);
    final decodedResponse = json.decode(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 403) {
      throw AuthenticationException(msg: decodedResponse['detail'].toString());
    } else {
      throw ServerException(
          msg: decodedResponse['detail'][0]['msg'].toString());
    }
  }

  @override
  Future<UserModel> verifySignIn(Map user) {
    Map body = {};
    Uri url = Uri();

    if (user["loginType"] == LoginType.email) {
      body = {
        "code": user['code'],
        "email": user['email'],
      };
      url = MetinAPI.verifyUserEmail;
    } else if (user["loginType"] == LoginType.phone) {
      body = {
        "phone_code": {
          "phone_code": user["phone_code"],
          "country": user["country"]
        },
        "phone": user["phone"],
        "code": user["code"]
      };
      url = MetinAPI.verifyUserPhone;
    }
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "accept": "application/json",
    };

    return _getUserFromUrl(
      url,
      body,
      headers,
    );
  }

  @override
  Future<bool> checkUserExistenceEmail(String email) async {
    final url =
        MetinAPI.checkUserExistence.replace(queryParameters: {"email": email});
    Map<String, String> headers = {
      "accept": "*/*",
    };

    final response = await http.get(url, headers: headers);
    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else if (response.statusCode == 422) {
      final decodedResponse = json.decode(response.body);
      throw AuthenticationException(
          msg: decodedResponse['detail'][0]['msg'].toString());
    } else {
      final decodedResponse = json.decode(response.body);

      throw ServerException(msg: decodedResponse['detail'].toString());
    }
  }

  @override
  Future<bool> registerFullName(Map<dynamic, dynamic> name) async {
    Map data = {
      "first_name": name["first_name"],
      "last_name": name["last_name"]
    };
    String body = json.encode(data);
    String path = MetinAPI.registerUserFullName.path
        .replaceFirst("user_id", "${name["id"]}");

    Uri url = MetinAPI.registerUserFullName.replace(path: path);

    final response = await http.put(url, body: body, headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
    });
    var decodedResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      throw AuthenticationException(msg: decodedResponse['detail'].toString());
    } else {
      throw ServerException(
          msg: decodedResponse['detail'][0]['msg'].toString());
    }
  }

  @override
  Future<ProfileModel> registerProfile(Map<dynamic, dynamic> info) async {
    Map data = {
      "birthday": null,
      "bio": null,
      "location": null,
      "gender": null,
      "industry": null
    };
    String token = info["token"];
    String body = json.encode(data);

    Map<String, String> headers = {
      "accept": "application/json",
      "user-access-token": token,
      "Content-Type": "application/json",
    };

    final url = MetinAPI.registerUserProfile;

    final response = await http.post(url, body: body, headers: headers);
    var decodedResponse = json.decode(response.body);

    if (response.statusCode == 201) {
      final profile = ProfileModel.fromJson(decodedResponse);
      return profile;
    } else if (response.statusCode == 422) {
      throw AuthenticationException(
          msg: decodedResponse['detail'][0]['msg'].toString());
    } else {
      throw ServerException(msg: decodedResponse['detail'].toString());
    }
  }

  @override
  Future<ProfileModel> getUserProfile(String token) async {
    final url = MetinAPI.registerUserProfile;

    Map<String, String> headers = {
      "accept": "application/json",
      "user-access-token": token,
    };

    final response = await http.get(url, headers: headers);
    var decodedResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      final profile = ProfileModel.fromJson(decodedResponse);
      return profile;
    } else if (response.statusCode == 404) {
      throw AuthenticationException(msg: decodedResponse['detail'].toString());
    } else {
      throw ServerException(
          msg: decodedResponse['detail'][0]['msg'].toString());
    }
  }

  @override
  Future<ProfileModel> updateProfile(Map<dynamic, dynamic> info) async {
    Map data = {
      "birthday": info["birthday"],
      "bio": info['bio'],
      "industry": info["industry"],
      "gender": info["gender"],
      "location": "New York",
    };
    String body = json.encode(data);

    Map<String, String> headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
    };

    final url = MetinAPI.registerUserProfile.replace(
      path: MetinAPI.registerUserProfile.path + info['id'].toString(),
    ); // add id

    final response = await http.put(url, body: body, headers: headers);
    var decodedResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      final profile = ProfileModel.fromJson(decodedResponse);
      return profile;
    } else if (response.statusCode == 422) {
      throw AuthenticationException(
          msg: decodedResponse['detail'][0]['msg'].toString());
    } else {
      throw ServerException(msg: decodedResponse['detail'].toString());
    }
  }
}
