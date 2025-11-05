import 'package:equatable/equatable.dart';
import 'package:sprint3_app/models/cms/carousel_cms_model.dart';
import 'package:sprint3_app/models/cms/news_source_cms_model.dart';
import 'package:sprint3_app/models/dto/news_source_dto.dart';

class CarouselDTO extends Equatable {
  final List<NewsSourceDTO> newsSources;

  const CarouselDTO({required this.newsSources});

  factory CarouselDTO.fromCMS(CarouselCMSModel? cmsModel) {
    if (cmsModel == null) {
      CarouselDTO(newsSources: []);
    }

    final List<NewsSourceCMSModel>? newsSourcesCMS = cmsModel?.newsSources;
    final List<NewsSourceDTO>? newsSourcesDTO = newsSourcesCMS
        ?.map(
          (element) => NewsSourceDTO.fromCMS(element)
        )
        .toList();

    return CarouselDTO(
      newsSources: newsSourcesDTO ?? []
    );
  }

  CarouselCMSModel toCMS() {
    final List<NewsSourceCMSModel> newsSourcesCMS = newsSources
        .map(
          (element) => element.toCMS()
        )
        .toList();

    return CarouselCMSModel(
      newsSources: newsSourcesCMS
    );
  }

@override
  List<Object?> get props => [newsSources];
}
