part of 'swipe_bloc.dart';

class SwipeState extends Equatable {
  const SwipeState({
    required this.startPosition,
    required this.updatePosition,
    required this.screenSize,
    required this.profiles,
  });

  final DragStartDetails startPosition;
  final DragUpdateDetails updatePosition;
  final Size screenSize;
  final List<Profile> profiles;

  SwipeState copyWith({
    DragStartDetails? startPosition,
    DragUpdateDetails? updatePosition,
    Size? screenSize,
    List<Profile>? profiles,
  }) {
    return SwipeState(
      startPosition: startPosition ?? this.startPosition,
      updatePosition: updatePosition ?? this.updatePosition,
      screenSize: screenSize ?? this.screenSize,
      profiles: profiles ?? this.profiles,
    );
  }

  @override
  List<Object> get props =>
      [startPosition, updatePosition, screenSize, profiles];
}
