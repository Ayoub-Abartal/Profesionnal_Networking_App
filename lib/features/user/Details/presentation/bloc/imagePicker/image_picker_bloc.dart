import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_compare/image_compare.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  /// Returns true if the image is not in the selected images
  Future<bool> checkImage(XFile? image, List<XFile?>? selectedImages) async {
    bool isUnique = true;
    for (XFile? im in selectedImages!) {
      File a = File(im!.path);
      File b = File(image!.path);
      double result =
          await compareImages(src1: a, src2: b, algorithm: AverageHash());
      if (result == 0) {
        isUnique = false;
        break;
      }
    }
    return isUnique;
  }

  ImageBloc() : super(const ImageState(images: [])) {
    on<OnSelectSingleImageEvent>(_onSelectSingleImage);
    on<OnChangeSingleImageEvent>(_onChangeSingleImage);
    on<OnDeleteSingleImageEvent>(_onDeleteSingleImage);
    on<OnSwitchImageIndexEvent>(_onSwitchIndex);
  }

  Future<void> _onSelectSingleImage(
      OnSelectSingleImageEvent event, Emitter<ImageState> emit) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image =
          await picker.pickImage(source: event.imageSource, maxWidth: 1080);
      if (image == null) {
        return;
      }
      bool imageCheck = await checkImage(image, state.images);
      if (imageCheck) {
        emit(state.copyWith(
            image: image, images: List.of(state.images!.toList())..add(image)));
      }
    } on PlatformException catch (e) {
      //TODO: Implement this case
      SnackBar(
        content: Text(e.message.toString()),
      );
      //print('Failed to pick image $e');
    }
  }

  Future<void> _onChangeSingleImage(
      OnChangeSingleImageEvent event, Emitter<ImageState> emit) async {
    final ImagePicker picker = ImagePicker();

    try {
      final XFile? image =
          await picker.pickImage(source: event.imageSource, maxWidth: 1080);
      if (image == null) {
        return;
      }
      bool imageCheck = await checkImage(image, state.images);
      if (imageCheck) {
        final newUpdatedList = List.of(state.images!.toList());
        newUpdatedList[event.index] = image;
        emit(
          state.copyWith(image: image, images: newUpdatedList),
        );
      }
    } on PlatformException catch (e) {
      SnackBar(
        content: Text(e.message.toString()),
      );
    }
  }

  void _onDeleteSingleImage(
      OnDeleteSingleImageEvent event, Emitter<ImageState> emit) {
    // If there is an element at that index we remove it.
    if (state.images!.length - 1 >= event.index) {
      emit(state.copyWith(
          images: List.of(state.images!.toList())..removeAt(event.index)));
    }
  }

  void _onSwitchIndex(OnSwitchImageIndexEvent event, Emitter<ImageState> emit) {
    if (event.indexA > state.images!.length - 1 ||
        event.indexB > state.images!.length - 1) {
      return;
    }
    var imageA = state.images![event.indexA];
    var imageB = state.images![event.indexB];

    emit(state.copyWith(
        images: List.of(state.images!.toList())
          ..removeAt(event.indexA)
          ..insert(event.indexA, imageB)
          ..removeAt(event.indexB)
          ..insert(event.indexB, imageA)));
  }
}
