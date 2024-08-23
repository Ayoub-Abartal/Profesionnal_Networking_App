import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/features/swipe/presentation/widgets/profile_card.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  Offset _position = Offset.zero;
  Size _screenSize = Size.zero;
  double _angle = 0;
  bool _isDragging = false;

  bool get isDragging => _isDragging;
  Offset get position => _position;
  double get angle => _angle;

  void setScreenSize(Size screenSize) => _screenSize = screenSize;

  SwipeStatus? getStatus({bool force = false}) {
    final x = _position.dx;
    final y = _position.dy;
    final forceSuperLike = x.abs() < 20;
    if (force) {
      const delta = 150;

      if (x >= delta) {
        return SwipeStatus.like;
      } else if (x <= -delta) {
        return SwipeStatus.dislike;
      } else if (y <= -delta / 2 && forceSuperLike) {
        return SwipeStatus.superLike;
      }
    } else {
      const delta = 20;

      if (y <= -delta * 2 && forceSuperLike) {
        return SwipeStatus.superLike;
      } else if (x >= delta) {
        return SwipeStatus.like;
      } else if (x <= -delta) {
        return SwipeStatus.dislike;
      }
    }
    return null;
  }

  double getStatusOpacity() {
    const delta = 100;
    final pos = max(_position.dx.abs(), _position.dy.abs());
    final opacity = pos / delta;

    return min(opacity, 1);
  }

  void like() {
    _angle = 20;
    _position += Offset(_screenSize.width * 2, 0);
  }

  void dislike() {
    _angle = -20;
    _position -= Offset(_screenSize.width * 2, 0);
  }

  void superLike() {
    _angle = 0;
    _position -= Offset(0, _screenSize.height);
  }

  void nextCard() {
    if (state.profiles.isEmpty) {
      return;
    }

    state.profiles.removeLast();
    resetPosition();
  }

  void resetPosition() {
    _isDragging = false;
    _angle = 0;
    _position = Offset.zero;
  }

  SwipeBloc()
      : super(
          SwipeState(
            startPosition: DragStartDetails(),
            updatePosition: DragUpdateDetails(globalPosition: Offset.zero),
            screenSize: const Size(0, 0),
            profiles: swipeProfiles,
          ),
        ) {
    on<SwipeStartPosition>((event, emit) {
      _isDragging = true;
      emit(state.copyWith(startPosition: event.startPosition));
    });

    on<SwipeUpdatePosition>((event, emit) {
      _position += event.updatePosition.delta;

      final x = _position.dx;
      _angle = 45 * x / _screenSize.width;

      emit(state.copyWith(updatePosition: event.updatePosition));
    });

    on<SwipeEndPosition>(
      (event, emit) async {
        void notifyListeners() {
          emit(
            state.copyWith(
              updatePosition: DragUpdateDetails(
                globalPosition: Offset(
                  _position.dx,
                  _position.dy,
                ),
              ),
            ),
          );
        }

        _isDragging = false;
        notifyListeners();
        final status = getStatus(force: true);

        switch (status) {
          case SwipeStatus.like:
            like();

            await Future.delayed(const Duration(milliseconds: 200));
            nextCard();
            break;
          case SwipeStatus.dislike:
            dislike();

            await Future.delayed(const Duration(milliseconds: 200));
            nextCard();
            break;
          case SwipeStatus.superLike:
            superLike();

            await Future.delayed(const Duration(milliseconds: 200));
            nextCard();
            break;
          default:
            resetPosition();
            break;
        }
        notifyListeners();
      },
    );

    on<SwipeCardScreenSize>((event, emit) {
      _screenSize = event.screenSize;
      emit(state.copyWith(screenSize: event.screenSize));
    });
  }
}
