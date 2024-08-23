part of 'image_picker_bloc.dart';

abstract class ImageEvent extends Equatable {}

class OnSelectMultipleImageEvent extends ImageEvent {
  final List<XFile>? images;

  OnSelectMultipleImageEvent(this.images);

  @override
  List<Object?> get props => [images];
}

class OnSelectSingleImageEvent extends ImageEvent {
  final ImageSource imageSource;

  OnSelectSingleImageEvent({required this.imageSource});

  @override
  List<Object?> get props => [imageSource];
}

class OnChangeSingleImageEvent extends ImageEvent {
  final int index;
  final ImageSource imageSource;
  OnChangeSingleImageEvent({required this.index, required this.imageSource});

  @override
  List<Object?> get props => [index, imageSource];
}

class OnDeleteSingleImageEvent extends ImageEvent {
  final int index;
  OnDeleteSingleImageEvent({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}

class OnSwitchImageIndexEvent extends ImageEvent {
  final int indexA;
  final int indexB;

  OnSwitchImageIndexEvent({required this.indexA, required this.indexB});

  @override
  List<Object?> get props => [indexA, indexB];
}
