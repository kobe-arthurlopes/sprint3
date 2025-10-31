import 'package:equatable/equatable.dart';
import 'package:sprint3_app/models/cms/carousel_cms_model.dart';
import 'package:sprint3_app/models/cms/news_source_cms_model.dart';
import 'package:sprint3_app/models/dto/news_source_dto_model.dart';

class CarouselDTOModel extends Equatable {
  final List<NewsSourceDTOModel> newsSources;

  const CarouselDTOModel({required this.newsSources});

  factory CarouselDTOModel.fromCMS(CarouselCMSModel? cmsModel) {
    if (cmsModel == null) {
      CarouselDTOModel(newsSources: []);
    }

    final List<NewsSourceCMSModel>? newsSourcesCMS = cmsModel?.newsSources;
    final List<NewsSourceDTOModel>? newsSourcesDTO = newsSourcesCMS
        ?.map(
          (element) => NewsSourceDTOModel.fromCMS(element)
        )
        .toList();

    return CarouselDTOModel(
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
