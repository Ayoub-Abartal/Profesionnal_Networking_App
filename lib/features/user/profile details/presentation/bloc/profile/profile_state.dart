part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final int phoneCode;
  final String phone;
  final String country;
  final String bio;
  final String education;
  final String industry;
  final String gender;
  final DateTime birthday;
  final List<String> languages;
  final List<String> skills;
  final List<String> interests;
  final List<String> links;
  final Map universities;
  final Map workExperiences;

  const ProfileState({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.phoneCode,
    required this.country,
    required this.bio,
    required this.education,
    required this.industry,
    required this.gender,
    required this.birthday,
    required this.languages,
    required this.skills,
    required this.interests,
    required this.links,
    required this.universities,
    required this.workExperiences,
  });

  ProfileState copyWith({
    int? id,
    String? fullName,
    String? email,
    int? phoneCode,
    String? phone,
    String? country,
    String? bio,
    String? search,
    String? education,
    String? industry,
    List<String>? languages,
    List<String>? skills,
    List<String>? interests,
    String? gender,
    DateTime? birthday,
    List<String>? links,
    Map? universities,
    Map? workExperiences,
  }) {
    return ProfileState(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      phoneCode: phoneCode ?? this.phoneCode,
      country: country ?? this.country,
      bio: bio ?? this.bio,
      education: education ?? this.education,
      industry: industry ?? this.industry,
      languages: languages ?? this.languages,
      skills: skills ?? this.skills,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      interests: interests ?? this.interests,
      universities: universities ?? this.universities,
      workExperiences: workExperiences ?? this.workExperiences,
      links: links ?? this.links,
    );
  }

  @override
  List<Object> get props => [
        id,
        fullName,
        email,
        phone,
        phoneCode,
        country,
        education,
        industry,
        languages,
        skills,
        interests,
        gender,
        birthday,
        links,
        universities,
        workExperiences,
        bio
      ];
}
