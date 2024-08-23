import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  const UserModel({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  final String accessToken;
  final String tokenType;
  final UserClass user;

  UserModel copyWith({
    String? accessToken,
    String? tokenType,
    UserClass? user,
  }) {
    return UserModel(
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      user: user ?? this.user,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        user: UserClass.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "user": user.toJson(),
      };
}

class UserClass {
  UserClass({
    required this.createdAt,
    required this.updatedAt,
    required this.id,
    required this.name,
    required this.email,
    required this.isConfirmed,
    required this.phone,
    required this.phoneCode,
    required this.isActive,
  });

  final DateTime createdAt;
  final DateTime updatedAt;
  final int id;
  final String name;
  final String email;
  final bool isConfirmed;
  final String phone;
  final PhoneCode phoneCode;
  final bool isActive;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"] ?? "0001-01-01"),
        id: json["id"],
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        isConfirmed: json["is_confirmed"],
        phone: json["phone"] ?? "",
        phoneCode: PhoneCode.fromJson(
            json["phone_code"] ?? {"phone_code": 000, "country": "none"}),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "id": id,
        "name": name,
        "email": email,
        "is_confirmed": isConfirmed,
        "phone": phone,
        "phone_code": phoneCode.toJson(),
        "is_active": isActive,
      };
}

class PhoneCode {
  PhoneCode({
    required this.phoneCode,
    required this.country,
  });

  final int phoneCode;
  final String country;

  factory PhoneCode.fromJson(Map<String, dynamic> json) => PhoneCode(
        phoneCode: json["phone_code"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "phone_code": phoneCode,
        "country": country,
      };
}
