import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/user/messages/presentation/bloc/broadcast/broadcast_bloc.dart';
import 'package:metin/features/user/messages/presentation/screens/broadcast_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaPicker extends StatefulWidget {
  const MediaPicker({Key? key}) : super(key: key);

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  // This will take all the assets we fetched
  List<AssetEntity> assets = [];

  void _fetchAssets() async {
    // Set onlyAll to true, to fetch only the 'Recent' album
    // which contains all the photos/videos in the storage
    final albums = await PhotoManager.getAssetPathList(
      onlyAll: true,
    );
    if (albums.isNotEmpty) {
      final recentAlbum = albums.first;

      // Fetch all the assets it contains
      final recentAssets = await recentAlbum.getAssetListRange(
        start: 0,
        end: 1000000, // end at a very big index (to get all the assets)
      );

      // Update the state and notify UI
      setState(() => assets = recentAssets);
    }
  }

  @override
  void initState() {
    _fetchAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final broadcastBloc = context.read<BroadcastBloc>();
    return Column(
      children: [
        Text(
          "Gallery",
          style: Theme.of(context).textTheme.headline3,
        ),
        SizedBox(
          height: aHeight(85, context),
          child: assets.isNotEmpty
              ? GridView.builder(
                  //padding: const EdgeInsets.symmetric(horizontal: 5),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // A grid view with 3 items per row
                    crossAxisCount: 3,
                  ),
                  itemCount: assets.length,
                  itemBuilder: (_, index) {
                    return AssetThumbnail(
                      asset: assets[index],
                      onTap: () async {
                        await assets[index].file.then((value) {
                          broadcastBloc.add(ChooseMediaBroadcast(
                              media: XFile(value!.path),
                              mediaType: MediaType.image));
                          Navigator.pushNamed(context, '/media-preview');
                        });
                      },
                    );
                  },
                )
              : const Center(
                  child: Text("No media found in gallery"),
                ),
        ),
      ],
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;
  final void Function()? onTap;

  String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  const AssetThumbnail({Key? key, required this.asset, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // We're using a FutureBuilder since thumbData is a future
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailData,
      builder: (_, snapshot) {
        final bytes = snapshot.data;
        // If we have no data, display a spinner
        if (bytes == null) {
          return const Center(child: CircularProgressIndicator());
        }
        // If there's data an image
        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.memory(
                      bytes,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Display a Play icon if the asset is a video
                if (asset.type == AssetType.video)
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Row(
                      children: [
                        Text(
                          _videoDuration(asset.videoDuration).toString(),
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                        ),
                        const Icon(
                          Icons.video_camera_back,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
