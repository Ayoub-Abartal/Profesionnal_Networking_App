part of 'swipe_bloc.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object> get props => [];
}

class SwipeStartPosition extends SwipeEvent {
  final DragStartDetails startPosition;

  const SwipeStartPosition({required this.startPosition});
}

class SwipeUpdatePosition extends SwipeEvent {
  final DragUpdateDetails updatePosition;

  const SwipeUpdatePosition({required this.updatePosition});
}

class SwipeEndPosition extends SwipeEvent {
  const SwipeEndPosition();
}

class SwipeCardScreenSize extends SwipeEvent {
  final Size screenSize;

  const SwipeCardScreenSize({required this.screenSize});
}
