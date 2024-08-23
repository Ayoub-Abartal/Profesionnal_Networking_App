part of 'broadcast_bloc.dart';

abstract class BroadcastEvent extends Equatable {
  const BroadcastEvent();

  @override
  List<Object> get props => [];
}

class NextBroadcastProfile extends BroadcastEvent {
  final int index;
  const NextBroadcastProfile({required this.index});

  @override
  List<Object> get props => [index];
}

class PreviousBroadcastProfile extends BroadcastEvent {
  final int index;
  const PreviousBroadcastProfile({required this.index});

  @override
  List<Object> get props => [index];
}

class LoadBroadcast extends BroadcastEvent {
  final int index;
  const LoadBroadcast({required this.index});

  @override
  List<Object> get props => [index];
}

class ChooseMediaBroadcast extends BroadcastEvent {
  final XFile media;
  final MediaType mediaType;
  const ChooseMediaBroadcast({required this.media, required this.mediaType});

  @override
  List<Object> get props => [media, mediaType];
}

class InitializeCamera extends BroadcastEvent {
  final List<CameraDescription> cameras;
  const InitializeCamera({required this.cameras});

  @override
  List<Object> get props => [cameras];
}

class AddABroadcast extends BroadcastEvent {
  final Broadcast broadcast;
  const AddABroadcast({required this.broadcast});

  @override
  List<Object> get props => [broadcast];
}
