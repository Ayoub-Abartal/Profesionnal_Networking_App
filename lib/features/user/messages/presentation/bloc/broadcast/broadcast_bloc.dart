import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/features/user/messages/presentation/screens/broadcast_screen.dart';
import 'package:metin/features/user/messages/presentation/widgets/message_tile.dart';
import 'package:video_player/video_player.dart';

part 'broadcast_event.dart';
part 'broadcast_state.dart';

class BroadcastBloc extends Bloc<BroadcastEvent, BroadcastState> {
  BroadcastBloc()
      : super(
          BroadcastState(
            const [],
            null, // No value until the user wants to add a broadcast
            null, // same here
            controller: PageController(),
            currentBroadcastIndex: 0,
            profileBroadcasts: const [],
            broadcasts: contacts,
          ),
        ) {
    on<NextBroadcastProfile>((event, emit) {
      if (contacts.reversed.toList()[event.index].broadcasts.isEmpty) {
        return;
      }
      emit(state.copyWith(currentBroadcastIndex: event.index));
      state.controller.animateToPage(event.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutQuad);
    });

    on<PreviousBroadcastProfile>((event, emit) {
      emit(state.copyWith(currentBroadcastIndex: event.index));
      state.controller.animateToPage(event.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutQuad);
    });

    on<LoadBroadcast>((event, emit) {
      emit(state.copyWith(
          currentBroadcastIndex: event.index,
          controller: PageController(initialPage: event.index)));
    });

    on<InitializeCamera>((event, emit) {
      emit(state.copyWith(camerasList: event.cameras));
    });

    on<ChooseMediaBroadcast>((event, emit) {
      emit(
        state.copyWith(
            newBroadcastMedia: event.media,
            newBroadcastMediaType: event.mediaType),
      );
    });

    on<AddABroadcast>((event, emit) {
      emit(
        state.copyWith(
          broadcasts: List.of(state.broadcasts.toList())
            ..[0].broadcasts.add(event.broadcast),
        ),
      );
    });
  }
}
