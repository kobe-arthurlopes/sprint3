import 'package:equatable/equatable.dart';
import 'package:sprint3_app/models/banner_dto_model.dart';
import 'package:sprint3_app/models/carousel_dto_model.dart';
import 'package:sprint3_app/models/cms/banner_cms_model.dart';
import 'package:sprint3_app/models/cms/carousel_cms_model.dart';
import 'package:sprint3_app/models/cms/home_cms_model.dart';

class HomeDTOModel extends Equatable {
  final String title;
  final CarouselDTOModel carousel;
  final List<BannerDTOModel> banners;

  const HomeDTOModel({
    required this.title,
    required this.carousel,
    required this.banners
  });

  factory HomeDTOModel.fromCMS(HomeCMSModel? cmsModel) {
    final String title = cmsModel?.title ?? 'No title';
    final CarouselCMSModel? carouselCMS = cmsModel?.carousel;
    final CarouselDTOModel carouselDTO = CarouselDTOModel.fromCMS(carouselCMS);
    final List<BannerCMSModel>? bannersCMS = cmsModel?.banners;
    final List<BannerDTOModel>? bannersDTO = bannersCMS
        ?.map(
          (element) => BannerDTOModel.fromCMS(element)
        )
        .toList();

    return HomeDTOModel(
      title: title,
      carousel: carouselDTO,
      banners: bannersDTO ?? [] 
    );
  }

  HomeCMSModel toCMS() {
    final CarouselCMSModel carouselCMS = carousel.toCMS();
    final List<BannerCMSModel> bannersCMS = banners
        .map(
          (element) => element.toCMS()
        )
        .toList();

    return HomeCMSModel(
      title: title,
      carousel: carouselCMS,
      banners: bannersCMS
    );
  }

  @override
  List<Object?> get props => [title, carousel, banners];
}