import 'package:equatable/equatable.dart';
import 'package:sprint3_app/models/carousel_dto_model.dart';
import 'package:sprint3_app/models/cms/carousel_cms_model.dart';
import 'package:sprint3_app/models/cms/home_cms_model.dart';

class HomeDTOModel extends Equatable {
  final CarouselDTOModel carousel;
  final String title;

  const HomeDTOModel({
    required this.carousel,
    required this.title
  });

  factory HomeDTOModel.fromCMS(HomeCMSModel cmsModel) {
    final CarouselCMSModel? carouselCMS = cmsModel.carousel;
    final CarouselDTOModel carouselDTO = CarouselDTOModel.fromCMS(carouselCMS);
    final String title = cmsModel.title ?? 'No title';

    return HomeDTOModel(
      carousel: carouselDTO, 
      title: title
    );
  }

  HomeCMSModel toCMS() {
    final CarouselCMSModel carouselCMS = carousel.toCMS();

    return HomeCMSModel(
      carousel: carouselCMS,
      title: title
    );
  }

  @override
  List<Object?> get props => [carousel, title];
}