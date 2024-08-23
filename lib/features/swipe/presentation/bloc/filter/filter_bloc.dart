import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc()
      : super(
          const FilterState(
            distance: 40,
            age: 25,
            industry: "Industry",
            skills: [],
            interests: [],
          ),
        ) {
    on<FilterInterestSelected>((event, emit) {
      emit(state.copyWith(
          interests: List.of(state.interests.toList())..add(event.interest)));
    });

    on<FilterInterestDeselected>((event, emit) {
      emit(state.copyWith(
          interests: List.of(state.interests.toList())
            ..remove(event.interest)));
    });

    on<FilterDistanceChanged>((event, emit) {
      emit(state.copyWith(distance: event.distance));
    });

    on<FilterAgeChanged>((event, emit) {
      emit(state.copyWith(age: event.age));
    });

    on<FilterIndustryChanged>((event, emit) {
      emit(state.copyWith(industry: event.industry));
    });

    on<FilterSkillSelected>((event, emit) {
      emit(state.copyWith(
          skills: List.of(state.skills.toList())..add(event.skill)));
    });

    on<FilterSkillDeselected>((event, emit) {
      emit(state.copyWith(
          skills: List.of(state.skills.toList())..remove(event.skill)));
    });
  }
}
