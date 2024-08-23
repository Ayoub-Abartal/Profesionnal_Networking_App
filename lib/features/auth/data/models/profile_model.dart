import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    required this.id,
    required this.birthday,
    required this.userId,
    required this.location,
    required this.bio,
    required this.gender,
    required this.industry,
    required this.yearsOfExperience,
    required this.educationLevel,
  });

  final int id;
  final DateTime birthday;
  final int userId;
  final String location;
  final String bio;
  final String gender;
  final String industry;
  final int yearsOfExperience;
  final String educationLevel;

  ProfileModel copyWith({
    int? id,
    DateTime? birthday,
    int? userId,
    String? location,
    String? bio,
    String? gender,
    String? industry,
    int? yearsOfExperience,
    String? educationLevel,
  }) =>
      ProfileModel(
        id: id ?? this.id,
        birthday: birthday ?? this.birthday,
        userId: userId ?? this.userId,
        location: location ?? this.location,
        bio: bio ?? this.bio,
        gender: gender ?? this.gender,
        industry: industry ?? this.industry,
        yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
        educationLevel: educationLevel ?? this.educationLevel,
      );

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        birthday: DateTime.parse(json["birthday"] ?? "0001-01-01"),
        userId: json["user_id"],
        location: json["location"] ?? "",
        bio: json["bio"] ?? "",
        gender: json["gender"] ?? "",
        industry: json["industry"] ?? "",
        yearsOfExperience: json["years_of_experience"] ?? 0,
        educationLevel: json["education_level"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "user_id": userId,
        "location": location,
        "bio": bio,
        "gender": gender,
        "industry": industry,
        "years_of_experience": yearsOfExperience,
        "education_level": educationLevel,
      };
}
