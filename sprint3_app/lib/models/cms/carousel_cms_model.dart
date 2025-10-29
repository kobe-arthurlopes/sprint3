import 'package:sprint3_app/helpers/string_extension.dart';
import 'package:sprint3_app/models/cms/cms_model.dart';
import 'package:sprint3_app/models/cms/news_source_cms_model.dart';

class CarouselCMSModel extends AutoRegisterCmsModel<CarouselCMSModel> {
  final List<NewsSourceCMSModel>? newsSources;

  const CarouselCMSModel({this.newsSources}) : super();

  static final register = CmsModel.registerModel<CarouselCMSModel>(() => CarouselCMSModel());

  @override
  final String contentType = 'carouselNewsSources';

  @override
  String fieldsQuery() {
    final String newsSourceContentType = CmsModel.contentTypeOf<NewsSourceCMSModel>();
    final String newsSourceFieldsQuery = CmsModel.fieldsQueryOf<NewsSourceCMSModel>();

    return '''
      ${newsSourceContentType}sCollection {
        items {
          ... on ${newsSourceContentType.capitalize()} {
            $newsSourceFieldsQuery
          }
        }
      }
    ''';
  }

  @override
  CmsModel fromJson(Map<String, dynamic> json) {
    final List<dynamic>? items =
    json['newsSourcesCollection']?['items'] as List<dynamic>?;

    return CarouselCMSModel(
      newsSources: items
          ?.map(
            (item) => CmsModel.fromJsonOf<NewsSourceCMSModel>(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'newsSources': newsSources
  };

  @override
  List<Object?> get props => [newsSources];
}