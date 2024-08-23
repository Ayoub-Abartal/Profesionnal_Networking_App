import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:metin/core/common/widgets/metin_text_field.dart';
import 'package:metin/core/utils/adaptive_h_w.dart';
import 'package:metin/features/user/messages/presentation/bloc/broadcast/broadcast_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import 'broadcast_screen.dart';

class ImageEditor extends StatefulWidget {
  const ImageEditor({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    final broadcastBloc = context.read<BroadcastBloc>();
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                onPressed: () {
                  saveToGallery(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Image saved to gallery")));
                },
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                tooltip: "Save image",
              ),
              IconButton(
                onPressed: increaseFontSize,
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                tooltip: "Increase font size",
              ),
              IconButton(
                onPressed: decreaseFontSize,
                icon: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                tooltip: "Decrease font size",
              ),
              PopupMenuButton(
                icon: textObjects.isEmpty || currentIndex == 0
                    ? const Icon(
                        Icons.circle,
                        color: Colors.white,
                      )
                    : Icon(
                        Icons.circle,
                        color: textObjects[currentIndex].color,
                      ),
                color: Colors.black,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    onTap: () => changeTextColor(Colors.white),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "White",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 1,
                    onTap: () => changeTextColor(Colors.red),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.circle,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Red",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                      value: 1,
                      onTap: () => changeTextColor(Colors.black),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Black",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                  PopupMenuItem(
                      value: 1,
                      onTap: () => changeTextColor(Colors.blue),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Blue",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                  PopupMenuItem(
                      value: 1,
                      onTap: () => changeTextColor(Colors.yellow),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.yellow,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Yellow",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                  PopupMenuItem(
                      value: 1,
                      onTap: () => changeTextColor(Colors.green),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.green,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Green",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                  PopupMenuItem(
                      value: 1,
                      onTap: () => changeTextColor(Colors.orange),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Orange",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                  PopupMenuItem(
                      value: 1,
                      onTap: () => changeTextColor(Colors.pink),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Colors.pink,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Pink",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                ],
              ),
              PopupMenuButton(
                icon: textObjects.isEmpty
                    ? const Icon(
                        Icons.format_align_left,
                        color: Colors.white,
                      )
                    : Icon(
                        textObjects[currentIndex].textAlign == TextAlign.left
                            ? Icons.format_align_left
                            : (textObjects[currentIndex].textAlign ==
                                    TextAlign.right
                                ? Icons.format_align_right
                                : Icons.format_align_center),
                        color: Colors.white,
                      ),
                color: Colors.black,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 0,
                    onTap: alignLeft,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.format_align_left,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Left",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 0,
                    onTap: alignCenter,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.format_align_center,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Center",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                      value: 0,
                      onTap: alignRight,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.format_align_right,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Right",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                ],
              ),
              IconButton(
                onPressed: boldText,
                icon: const Icon(
                  Icons.format_bold,
                  color: Colors.white,
                ),
                tooltip: "Bold",
              ),
              IconButton(
                onPressed: italicText,
                icon: const Icon(
                  Icons.format_italic,
                  color: Colors.white,
                ),
                tooltip: "Italic",
              ),
              IconButton(
                onPressed: addNewLine,
                icon: const Icon(
                  Icons.space_bar,
                  color: Colors.white,
                ),
                tooltip: "Add new line",
              ),
            ],
          ),
        ),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
          child: SizedBox(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    currentIndex = 0;
                  }),
                  child: Center(
                    child: Image.file(
                      File(broadcastBloc.state.newBroadcastMedia!.path),
                      fit: BoxFit.cover,
                      height: aHeight(90, context),
                      width: aWidth(100, context),
                    ),
                  ),
                ),
                for (int i = 0; i < textObjects.length; i++)
                  Positioned(
                    left: textObjects[i].left,
                    top: textObjects[i].top,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: currentIndex == i && i != 0
                              ? Colors.white
                              : Colors.transparent,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (currentIndex == i) {
                            editingController.text = textObjects[i].text;
                            addNewDialog(context, true);
                          } else {
                            setCurrentIndex(i);
                          }
                        },
                        onLongPress: () {
                          setState(() {
                            currentIndex = i;
                            removeText(context);
                          });
                        },
                        child: Draggable(
                          feedback: ImageText(textInfo: textObjects[i]),
                          child: ImageText(textInfo: textObjects[i]),
                          onDragEnd: (drag) {
                            final renderBox =
                                context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);
                            setState(() {
                              textObjects[i].top = off.dy - 65;
                              textObjects[i].left = off.dx;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                creatorText.text.isNotEmpty
                    ? Positioned(
                        left: 0,
                        bottom: 0,
                        child: Text(
                          creatorText.text,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNewDialog(context, false),
        tooltip: "Customize your image",
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add_circle_rounded,
          size: 50,
          color: Colors.black,
        ),
      ),
    );
  }
}

abstract class EditImageViewModel extends State<ImageEditor> {
  TextEditingController editingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> textObjects = [
    TextInfo(
      text: "",
      left: 0,
      top: 0,
      fontSize: 1,
      color: Colors.transparent,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      textAlign: TextAlign.left,
    )
  ];
  int currentIndex = 0;

  setCurrentIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  saveToGallery(BuildContext context) async {
    setState(() {
      currentIndex = 0;
    });
    var broadcastBloc = context.read<BroadcastBloc>();
    final directory = (await getApplicationDocumentsDirectory()).path;
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    String path = directory;

    screenshotController.capture().then((Uint8List? image) {
      saveImage(image!);
    });
    screenshotController
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
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll(".", "-")
        .replaceAll(":", "-");
    final name = "conmateedit_$time";
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  removeText(context) {
    if (textObjects.isNotEmpty) {
      setState(() {
        textObjects.removeAt(currentIndex);
        currentIndex--;
      });
    }
  }

  changeTextColor(Color color) {
    if (textObjects.isNotEmpty) {
      setState(() {
        textObjects[currentIndex].color = color;
      });
    }
  }

  increaseFontSize() {
    if (textObjects.isNotEmpty) {
      setState(() {
        textObjects[currentIndex].fontSize += 2;
      });
    }
  }

  decreaseFontSize() {
    if (textObjects.isNotEmpty) {
      setState(() {
        textObjects[currentIndex].fontSize -= 2;
      });
    }
  }

  alignLeft() {
    if (textObjects.isNotEmpty) {
      setState(() {
        textObjects[currentIndex].textAlign = TextAlign.left;
      });
    }
  }

  alignCenter() {
    if (textObjects.isNotEmpty) {
      setState(() {
        textObjects[currentIndex].textAlign = TextAlign.center;
      });
    }
  }

  alignRight() {
    if (textObjects.isNotEmpty) {
      setState(() {
        textObjects[currentIndex].textAlign = TextAlign.right;
      });
    }
  }

  boldText() {
    if (textObjects.isNotEmpty) {
      setState(() {
        if (textObjects[currentIndex].fontWeight == FontWeight.bold) {
          textObjects[currentIndex].fontWeight = FontWeight.normal;
        } else {
          textObjects[currentIndex].fontWeight = FontWeight.bold;
        }
      });
    }
  }

  italicText() {
    if (textObjects.isNotEmpty) {
      setState(() {
        if (textObjects[currentIndex].fontStyle == FontStyle.italic) {
          textObjects[currentIndex].fontStyle = FontStyle.normal;
        } else {
          textObjects[currentIndex].fontStyle = FontStyle.italic;
        }
      });
    }
  }

  addNewLine() {
    if (textObjects.isNotEmpty) {
      setState(() {
        if (textObjects[currentIndex].text.contains('\n')) {
          textObjects[currentIndex].text =
              textObjects[currentIndex].text.replaceFirst('\n', ' ');
        } else {
          textObjects[currentIndex].text =
              textObjects[currentIndex].text.replaceFirst(' ', '\n');
        }
      });
    }
  }

  addNewText(BuildContext context) {
    if (editingController.text.isNotEmpty) {
      setState(() {
        textObjects.add(
          TextInfo(
            text: editingController.text,
            left: 0,
            top: 0,
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.normal,
            textAlign: TextAlign.left,
          ),
        );
        currentIndex++;
        Navigator.of(context).pop();
      });
    }
  }

  editText(context) {
    if (editingController.text.isNotEmpty) {
      setState(() {
        textObjects[currentIndex].text = editingController.text;
      });
      Navigator.of(context).pop();
    }
  }

  addNewDialog(context, edit) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: MetinTextField(
          inputTextStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.white),
          borderColor: Colors.grey,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.white),
          controller: editingController,
          maxLines: 5,
          hintText: "Type something here...",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextButton(
              onPressed: () {
                if (edit) {
                  editText(context);
                } else {
                  addNewText(context);
                }
              },
              child: Text(
                edit ? "Save" : "Add text",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageText extends StatelessWidget {
  final TextInfo textInfo;

  const ImageText({Key? key, required this.textInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      textAlign: textInfo.textAlign,
      style: TextStyle(
        color: textInfo.color,
        fontSize: textInfo.fontSize,
        fontWeight: textInfo.fontWeight,
        fontStyle: textInfo.fontStyle,
      ),
    );
  }
}

class TextInfo {
  String text;
  double left, top, fontSize;
  Color color;
  FontWeight fontWeight;
  FontStyle fontStyle;
  TextAlign textAlign;

  TextInfo({
    required this.text,
    required this.left,
    required this.top,
    required this.fontSize,
    required this.color,
    required this.fontWeight,
    required this.fontStyle,
    required this.textAlign,
  });
}
