part of 'broadcast_bloc.dart';

class BroadcastState extends Equatable {
  final PageController controller;
  final int currentBroadcastIndex;
  final List<Widget> profileBroadcasts;
  final List<ContactProfile> broadcasts;
  final XFile? newBroadcastMedia;
  final MediaType? newBroadcastMediaType;
  final List<CameraDescription>? camerasList;

  const BroadcastState(
    this.camerasList,
    this.newBroadcastMedia,
    this.newBroadcastMediaType, {
    required this.controller,
    required this.currentBroadcastIndex,
    required this.profileBroadcasts,
    required this.broadcasts,
  });

  BroadcastState copyWith({
    PageController? controller,
    int? currentBroadcastIndex,
    List<Widget>? profileBroadcasts,
    List<ContactProfile>? broadcasts,
    XFile? newBroadcastMedia,
    MediaType? newBroadcastMediaType,
    List<CameraDescription>? camerasList,
    VideoPlayerController? videoPreviewController,
  }) {
    return BroadcastState(
      camerasList ?? this.camerasList,
      newBroadcastMedia ?? this.newBroadcastMedia,
      newBroadcastMediaType ?? this.newBroadcastMediaType,
      controller: controller ?? this.controller,
      currentBroadcastIndex:
          currentBroadcastIndex ?? this.currentBroadcastIndex,
      profileBroadcasts: profileBroadcasts ?? this.profileBroadcasts,
      broadcasts: broadcasts ?? this.broadcasts,
    );
  }

  @override
  List<Object?> get props => [
        controller,
        currentBroadcastIndex,
        profileBroadcasts,
        broadcasts,
        newBroadcastMedia,
        newBroadcastMediaType,
        camerasList,
      ];
}
