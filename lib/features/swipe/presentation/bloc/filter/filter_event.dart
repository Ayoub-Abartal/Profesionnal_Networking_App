part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class FilterInterestSelected extends FilterEvent {
  final String interest;

  const FilterInterestSelected({required this.interest});
}

class FilterInterestDeselected extends FilterEvent {
  final String interest;

  const FilterInterestDeselected({required this.interest});
}

class FilterDistanceChanged extends FilterEvent {
  final int distance;

  const FilterDistanceChanged({required this.distance});
}

class FilterAgeChanged extends FilterEvent {
  final int age;

  const FilterAgeChanged({required this.age});
}

class FilterIndustryChanged extends FilterEvent {
  final String industry;

  const FilterIndustryChanged({required this.industry});
}

class FilterSkillSelected extends FilterEvent {
  final String skill;

  const FilterSkillSelected({required this.skill});
}

class FilterSkillDeselected extends FilterEvent {
  final String skill;

  const FilterSkillDeselected({required this.skill});
}
