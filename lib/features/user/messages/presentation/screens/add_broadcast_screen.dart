import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metin/core/common/widgets/metin_bottom_sheet.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/user/messages/presentation/bloc/broadcast/broadcast_bloc.dart';
import 'package:metin/features/user/messages/presentation/screens/broadcast_screen.dart';
import 'package:metin/features/user/messages/presentation/widgets/media_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class AddBroadcastScreen extends StatefulWidget {
  const AddBroadcastScreen({Key? key, this.cameras}) : super(key: key);
  final List<CameraDescription>? cameras;

  @override
  State<AddBroadcastScreen> createState() => _AddBroadcastScreenState();
}

class _AddBroadcastScreenState extends State<AddBroadcastScreen> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  bool _isRecording = false;
  FlashMode _flashMode = FlashMode.off;
  String recordingTime = '00:00';
  XFile? media;
  MediaType? mediaType;

  Future initCamera(CameraDescription cameraDescription) async {
    // create a CameraController
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    // Next, initialize the controller. This returns a Future.
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  Future<void> switchFlashMode() async {
    if (_flashMode == FlashMode.off) {
      await _cameraController.setFlashMode(FlashMode.auto);
      setState(() {
        _flashMode = FlashMode.auto;
      });
    } else if (_flashMode == FlashMode.auto) {
      await _cameraController.setFlashMode(FlashMode.always);
      setState(() {
        _flashMode = FlashMode.always;
      });
    } else {
      await _cameraController.setFlashMode(FlashMode.off);
      setState(() {
        _flashMode = FlashMode.off;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // initialize the rear camera
    // 0 rear - 1 front
    initCamera(context.read<BroadcastBloc>().state.camerasList![0]);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final broadcastBloc = context.read<BroadcastBloc>();

    Future takePicture() async {
      if (!_cameraController.value.isInitialized) {
        return null;
      }
      if (_cameraController.value.isTakingPicture) {
        return null;
      }
      try {
        await _cameraController.takePicture().then((value) {
          setState(() {
            broadcastBloc.add(
                ChooseMediaBroadcast(media: value, mediaType: MediaType.image));
            Navigator.pushNamed(context, '/media-preview');
          });
        });
      } on CameraException catch (e) {
        debugPrint('Error occurred while taking picture: $e');
        return null;
      }
    }

    Future<void> stopRecording() async {
      setState(() {
        _isRecording = false;
      });
      await _cameraController.stopVideoRecording().then((value) {
        setState(() {
          broadcastBloc.add(
              ChooseMediaBroadcast(media: value, mediaType: MediaType.video));
          Navigator.pushNamed(context, '/media-preview');
        });
      });
    }

    void recordTime() {
      var startTime = DateTime.now();
      Timer.periodic(const Duration(seconds: 1), (Timer t) {
        var diff = DateTime.now().difference(startTime);

        int seconds = diff.inSeconds < 60 ? diff.inSeconds : 0;

        recordingTime = '00:${seconds.toString().padLeft(2, "0")}';

        if (seconds >= 30) {
          stopRecording();
        }

        if (!_isRecording) {
          t.cancel(); // cancel function calling
          recordingTime = "00:00";
        }

        setState(() {});
      });
    }

    Future takeVideo() async {
      if (!_cameraController.value.isInitialized) {
        return null;
      }
      if (_cameraController.value.isTakingPicture) {
        return null;
      }
      try {
        //await _cameraController.setFlashMode(FlashMode.off);
        await _cameraController.prepareForVideoRecording();
        await _cameraController.startVideoRecording();
        recordTime();
        setState(() {
          _isRecording = true;
        });
      } on CameraException catch (e) {
        debugPrint('Error occurred while taking picture: $e');
        return null;
      }
    }

    Widget backGroundPicker() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Choose a Background",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          SizedBox(
            height: aHeight(80, context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.count(
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 3,
                children: List.generate(
                  backgrounds.length,
                  (index) {
                    ScreenshotController scsController = ScreenshotController();
                    return GestureDetector(
                      onTap: () async {
                        final directory =
                            (await getApplicationDocumentsDirectory()).path;
                        String fileName =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        String path = directory;

                        scsController
                            .captureAndSave(path, fileName: fileName)
                            .then((String? image) {
                          broadcastBloc.add(
                            ChooseMediaBroadcast(
                              media: XFile(image!),
                              mediaType: MediaType.image,
                            ),
                          );

                          return Navigator.pushNamed(context, '/media-preview');
                        });
                      },
                      child: Screenshot(
                        controller: scsController,
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: backgrounds[index],
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: _cameraController.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        children: [
                          SizedBox(
                              height: aHeight(80, context),
                              width: aWidth(100, context),
                              child: CameraPreview(_cameraController)),
                          Positioned(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: switchFlashMode,
                                icon: Icon(
                                  _flashMode == FlashMode.off
                                      ? Icons.flash_off
                                      : (_flashMode == FlashMode.auto
                                          ? Icons.flash_auto
                                          : Icons.flash_on),
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          )),
                          Positioned(
                            bottom: 2,
                            right: 0,
                            left: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if (_isRecording)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.circle,
                                        color: Colors.red,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 3.0),
                                        child: Text(
                                          recordingTime,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                InkWell(
                                  onTap: () {
                                    if (_isRecording) {
                                      stopRecording();
                                    } else {
                                      takePicture();
                                    }
                                  },
                                  onLongPress: takeVideo,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Icon(
                                          Icons.circle_outlined,
                                          size: 80,
                                          color: _isRecording
                                              ? Colors.red
                                              : Colors.black45,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        left: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: Icon(
                                          _isRecording
                                              ? Icons.stop_circle
                                              : Icons.circle,
                                          color: Colors.white,
                                          size: 70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MetinBottomSheet(
                                                content: backGroundPicker()));
                                      },
                                      child: Container(
                                        height: aHeight(5, context),
                                        width: aHeight(5, context),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: const Icon(
                                          Icons.sort_by_alpha_rounded,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          iconSize: 35,
                          icon: const Icon(
                            Icons.photo,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MetinBottomSheet(
                                content: BlocProvider.value(
                                  value: broadcastBloc,
                                  child: const MediaPicker(),
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          iconSize: 35,
                          icon: Icon(
                              _isRearCameraSelected
                                  ? Icons.cameraswitch
                                  : Icons.cameraswitch_outlined,
                              color: Colors.white),
                          onPressed: () {
                            setState(() =>
                                _isRearCameraSelected = !_isRearCameraSelected);
                            initCamera(
                              broadcastBloc.state
                                  .camerasList![_isRearCameraSelected ? 0 : 1],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
