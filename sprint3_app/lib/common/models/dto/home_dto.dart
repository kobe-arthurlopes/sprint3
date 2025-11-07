import 'package:equatable/equatable.dart';
import 'package:sprint3_app/common/models/dto/banner_dto.dart';
import 'package:sprint3_app/common/models/dto/carousel_dto.dart';
import 'package:sprint3_app/common/models/cms/banner_cms_model.dart';
import 'package:sprint3_app/common/models/cms/carousel_cms_model.dart';
import 'package:sprint3_app/common/models/cms/home_cms_model.dart';

class HomeDTO extends Equatable {
  final String title;
  final CarouselDTO carousel;
  final List<BannerDTO> banners;

  const HomeDTO({
    required this.title,
    required this.carousel,
    required this.banners
  });

  factory HomeDTO.fromCMS(HomeCMSModel? cmsModel) {
    final String title = cmsModel?.title ?? 'No title';
    final CarouselCMSModel? carouselCMS = cmsModel?.carousel;
    final CarouselDTO carouselDTO = CarouselDTO.fromCMS(carouselCMS);
    final List<BannerCMSModel>? bannersCMS = cmsModel?.banners;
    final List<BannerDTO>? bannersDTO = bannersCMS
        ?.map(
          (element) => BannerDTO.fromCMS(element)
        )
        .toList();

    return HomeDTO(
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