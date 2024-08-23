part of 'image_picker_bloc.dart';

class ImageState extends Equatable {
  final XFile? image;
  final List<XFile?>? images;
  const ImageState({this.image, this.images});

  ImageState copyWith({XFile? image, List<XFile?>? images, int? index}) =>
      ImageState(
        image: image ?? this.image,
        images: images ?? this.images,
      );

  @override
  List<Object?> get props => [image, images];
}
