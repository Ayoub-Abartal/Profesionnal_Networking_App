import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/user/Details/presentation/bloc/imagePicker/image_picker_bloc.dart';

class MyImagePicker extends StatefulWidget {
  const MyImagePicker({
    Key? key,
    required this.photoContainerSize,
    required this.iconButtonSize,
    required this.iconContainerSize,
    required this.index,
  }) : super(key: key);

  /// The selected image view size
  final Size photoContainerSize;

  /// The select image button icon size
  final double iconButtonSize;

  /// The icon box size
  final Size iconContainerSize;

  /// The key that identify the image picker
  final int index;

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  double scale = 1;

  @override
  Widget build(BuildContext context) {
    final imageBloc = BlocProvider.of<ImageBloc>(context);
    return Draggable(
      onDragEnd: (d) {
        setState(() {
          scale = 1;
        });
      },
      data: widget.index,
      childWhenDragging: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
        height: widget.photoContainerSize.height,
        width: widget.photoContainerSize.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(width: 1, color: Colors.grey)),
      ),
      feedback: BlocProvider.value(
        value: imageBloc,
        child: widget,
      ),
      child: DragTarget(
        onWillAccept: (d) {
          setState(() {
            scale = 1.31;
          });
          return true;
        },
        onLeave: (d) {
          setState(() {
            scale = 1;
          });
        },
        onAccept: (data) {
          setState(() {
            scale = 1;
          });
          imageBloc.add(
            OnSwitchImageIndexEvent(
              indexA: widget.index,
              indexB: int.parse(
                data.toString(),
              ),
            ),
          );
        },
        builder: (context, _, __) {
          return Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              BlocBuilder<ImageBloc, ImageState>(
                builder: (context, state) =>
                    state.images!.asMap().containsKey(widget.index)
                        ? AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 1),
                            height: widget.photoContainerSize.height * scale,
                            width: widget.photoContainerSize.width * scale,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: const Color(0xffE8E6EA)),
                            clipBehavior: Clip.hardEdge,
                            child: Image.file(
                              File(state.images![widget.index]!.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 3.0, vertical: 1),
                            height: widget.photoContainerSize.height,
                            width: widget.photoContainerSize.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: const Color(0xffE8E6EA)),
                            clipBehavior: Clip.hardEdge,
                          ),
              ),
              BlocBuilder<ImageBloc, ImageState>(
                builder: ((context, state) => state.images!
                            .asMap()
                            .containsKey(widget.index - 1) ||
                        widget.index == 0
                    ? Positioned(
                        bottom: aHeight(0.01, context),
                        right: aWidth(0.01, context),
                        height: widget.iconContainerSize.height,
                        width: widget.iconContainerSize.width,
                        child: RawMaterialButton(
                          padding: const EdgeInsets.all(10.0),
                          elevation: 0,
                          fillColor: const Color(0xff2683E0),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Choose an option : "),
                                    content: SingleChildScrollView(
                                      child: ListBody(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () async {
                                              if (state.images!
                                                  .asMap()
                                                  .containsKey(widget.index)) {
                                                imageBloc.add(
                                                    OnChangeSingleImageEvent(
                                                        index: widget.index,
                                                        imageSource: ImageSource
                                                            .camera));
                                              } else {
                                                imageBloc.add(
                                                    OnSelectSingleImageEvent(
                                                        imageSource: ImageSource
                                                            .camera));
                                              }

                                              Navigator.pop(context);
                                            },
                                            child: Row(children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: FaIcon(
                                                    FontAwesomeIcons.camera,
                                                    size: 18,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              Text(
                                                "Camera",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                              ),
                                            ]),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: () async {
                                              if (state.images!
                                                  .asMap()
                                                  .containsKey(widget.index)) {
                                                imageBloc.add(
                                                    OnChangeSingleImageEvent(
                                                        index: widget.index,
                                                        imageSource: ImageSource
                                                            .gallery));
                                              } else {
                                                imageBloc.add(
                                                    OnSelectSingleImageEvent(
                                                        imageSource: ImageSource
                                                            .gallery));
                                              }

                                              Navigator.pop(context);
                                            },
                                            child: Row(children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: FaIcon(
                                                    FontAwesomeIcons.images,
                                                    size: 18,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                              Text(
                                                "Gallery",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button,
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ]),
                                    ),
                                  );
                                });
                          },
                          shape: const CircleBorder(
                              side: BorderSide(color: Colors.white, width: 5)),
                          child: Icon(
                            Icons.camera_alt,
                            size: widget.iconButtonSize,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container()),
              ),
              BlocBuilder<ImageBloc, ImageState>(
                builder: (context, state) {
                  if (imageBloc.state.images!.length - 1 >= widget.index) {
                    return Positioned(
                      top: 0,
                      right: 0,
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            imageBloc.add(
                                OnDeleteSingleImageEvent(index: widget.index));
                          },
                          icon: const Icon(
                            FontAwesomeIcons.xmark,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
