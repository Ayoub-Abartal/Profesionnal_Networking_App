part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final int distance;
  final int age;
  final String industry;
  final List<String> skills;
  final List<String> interests;

  const FilterState({
    required this.distance,
    required this.age,
    required this.industry,
    required this.skills,
    required this.interests,
  });

  FilterState copyWith({
    String? industry,
    int? age,
    int? distance,
    List<String>? interests,
    List<String>? skills,
  }) {
    return FilterState(
      industry: industry ?? this.industry,
      interests: interests ?? this.interests,
      age: age ?? this.age,
      distance: distance ?? this.distance,
      skills: skills ?? this.skills,
    );
  }

  @override
  List<Object> get props => [interests, industry, age, distance, skills];
}
