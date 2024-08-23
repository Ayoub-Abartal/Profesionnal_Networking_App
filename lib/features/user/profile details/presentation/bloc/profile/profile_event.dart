part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileIdChanged extends ProfileEvent {
  final int id;

  const ProfileIdChanged({required this.id});
}

class ProfileFullNameChanged extends ProfileEvent {
  final String fullName;

  const ProfileFullNameChanged({required this.fullName});
}

class ProfileEmailChanged extends ProfileEvent {
  final String email;

  const ProfileEmailChanged({
    required this.email,
  });
}

class ProfilePhoneChanged extends ProfileEvent {
  final String phone;

  const ProfilePhoneChanged({required this.phone});
}

class ProfilePhoneCodeChanged extends ProfileEvent {
  final int phoneCode;

  const ProfilePhoneCodeChanged({required this.phoneCode});
}

class ProfileCountryChanged extends ProfileEvent {
  final String country;

  const ProfileCountryChanged({required this.country});
}

class ProfileBioChanged extends ProfileEvent {
  final String bio;

  const ProfileBioChanged({required this.bio});
  @override
  List<Object> get props => [bio];
}

class ProfileEducationChanged extends ProfileEvent {
  final String education;

  const ProfileEducationChanged({required this.education});
  @override
  List<Object> get props => [education];
}

class ProfileIndustryChanged extends ProfileEvent {
  final String industry;

  const ProfileIndustryChanged({required this.industry});
  @override
  List<Object> get props => [industry];
}

class ProfileLanguageSelected extends ProfileEvent {
  final String language;

  const ProfileLanguageSelected({required this.language});
  @override
  List<Object> get props => [language];
}

class ProfileLanguageDeselected extends ProfileEvent {
  final String language;

  const ProfileLanguageDeselected({required this.language});
  @override
  List<Object> get props => [language];
}

class ProfileSkillSelected extends ProfileEvent {
  final String skill;

  const ProfileSkillSelected({required this.skill});
  @override
  List<Object> get props => [skill];
}

class ProfileSkillDeselected extends ProfileEvent {
  final String skill;

  const ProfileSkillDeselected({required this.skill});
  @override
  List<Object> get props => [skill];
}

class ProfileInterestSelected extends ProfileEvent {
  final String interest;

  const ProfileInterestSelected({required this.interest});
}

class ProfileInterestDeselected extends ProfileEvent {
  final String interest;

  const ProfileInterestDeselected({required this.interest});
}

class ProfileUniversityAdded extends ProfileEvent {
  final Map university;

  const ProfileUniversityAdded({required this.university});
}

class ProfileUniversityEdited extends ProfileEvent {
  final Map university;

  const ProfileUniversityEdited({required this.university});
}

class ProfileUniversityRemoved extends ProfileEvent {
  final String university;

  const ProfileUniversityRemoved({required this.university});
}

class ProfileWorkExpAdded extends ProfileEvent {
  final Map we;

  const ProfileWorkExpAdded({required this.we});
}

class ProfileWorkExpEdited extends ProfileEvent {
  final Map we;

  const ProfileWorkExpEdited({required this.we});
}

class ProfileWorkExpRemoved extends ProfileEvent {
  final String we;

  const ProfileWorkExpRemoved({required this.we});
}

class ProfileLinkAdded extends ProfileEvent {
  final String link;

  const ProfileLinkAdded({required this.link});
}

class ProfileBirthdayChanged extends ProfileEvent {
  final DateTime birthday;

  const ProfileBirthdayChanged({required this.birthday});
  @override
  List<Object> get props => [birthday];
}

class ProfileGenderChanged extends ProfileEvent {
  final String gender;

  const ProfileGenderChanged({required this.gender});
  @override
  List<Object> get props => [gender];
}

class ConfirmProfileChanges extends ProfileEvent {}
