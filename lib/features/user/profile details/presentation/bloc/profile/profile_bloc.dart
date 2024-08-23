import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc()
      : super(
          ProfileState(
            id: 0,
            fullName: "",
            email: "",
            phone: "",
            phoneCode: 212,
            country: "Morocco",
            bio: "",
            education: "Education",
            industry: "Industry",
            gender: "Not defined",
            skills: const [],
            languages: const [],
            interests: const [],
            links: const [],
            universities: const {},
            workExperiences: const {},
            birthday: DateTime(0000, 00, 00),
          ),
        ) {
    on<ProfileIdChanged>((event, emit) {
      emit(state.copyWith(
        id: event.id,
      ));
    });

    on<ProfileEmailChanged>((event, emit) {
      emit(state.copyWith(
        email: event.email,
      ));
    });

    on<ProfileFullNameChanged>((event, emit) {
      emit(state.copyWith(fullName: event.fullName));
    });

    on<ProfilePhoneChanged>((event, emit) {
      emit(state.copyWith(
        phone: event.phone,
      ));
    });

    on<ProfilePhoneCodeChanged>((event, emit) {
      emit(state.copyWith(
        phoneCode: event.phoneCode,
      ));
    });

    on<ProfileCountryChanged>((event, emit) {
      emit(state.copyWith(
        country: event.country,
      ));
    });

    on<ProfileBioChanged>((event, emit) {
      emit(state.copyWith(bio: event.bio));
    });

    on<ProfileEducationChanged>((event, emit) {
      emit(state.copyWith(education: event.education));
    });

    on<ProfileIndustryChanged>((event, emit) {
      emit(state.copyWith(industry: event.industry));
    });

    on<ProfileLanguageSelected>((event, emit) {
      emit(state.copyWith(
          languages: List.of(state.languages.toList())..add(event.language)));
    });

    on<ProfileGenderChanged>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<ProfileLanguageDeselected>((event, emit) {
      emit(state.copyWith(
          languages: List.of(state.languages.toList())
            ..remove(event.language)));
    });

    on<ProfileSkillSelected>((event, emit) {
      emit(state.copyWith(
          skills: List.of(state.skills.toList())..add(event.skill)));
    });

    on<ProfileSkillDeselected>((event, emit) {
      emit(state.copyWith(
          skills: List.of(state.skills.toList())..remove(event.skill)));
    });

    on<ProfileInterestSelected>((event, emit) {
      emit(state.copyWith(
          interests: List.of(state.interests.toList())..add(event.interest)));
    });

    on<ProfileInterestDeselected>((event, emit) {
      emit(state.copyWith(
          interests: List.of(state.interests.toList())
            ..remove(event.interest)));
    });

    on<ProfileUniversityAdded>((event, emit) {
      emit(state.copyWith(
          universities: Map.of(state.universities)..addAll(event.university)));
    });

    on<ProfileUniversityEdited>((event, emit) {
      emit(
        state.copyWith(
          universities: Map.of(state.universities)
            ..update(
              event.university.keys.toList().first,
              (value) => event.university.values.toList().first,
            ),
        ),
      );
    });

    on<ProfileUniversityRemoved>((event, emit) {
      emit(state.copyWith(
          universities: Map.of(state.universities)..remove(event.university)));
    });

    on<ProfileWorkExpAdded>((event, emit) {
      emit(state.copyWith(
          workExperiences: Map.of(state.workExperiences)..addAll(event.we)));
    });

    on<ProfileWorkExpEdited>((event, emit) {
      emit(
        state.copyWith(
          workExperiences: Map.of(state.workExperiences)
            ..update(
              event.we.keys.toList().first,
              (value) => event.we.values.toList().first,
            ),
        ),
      );
    });

    on<ProfileWorkExpRemoved>((event, emit) {
      emit(state.copyWith(
          workExperiences: Map.of(state.workExperiences)..remove(event.we)));
    });

    on<ProfileLinkAdded>((event, emit) {
      emit(state.copyWith(
          links: List.of(state.links.toList())..add(event.link)));
    });

    on<ProfileBirthdayChanged>((event, emit) {
      emit(state.copyWith(birthday: event.birthday));
    });

    on<ConfirmProfileChanges>((event, emit) {
      // To be Implemented
    });
  }
}
