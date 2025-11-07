import 'package:sprint3_app/common/helpers/string_extension.dart';
import 'package:sprint3_app/common/models/cms/cms_model.dart';
import 'package:sprint3_app/common/models/cms/news_source_cms_model.dart';

class CarouselCMSModel extends AutoRegisterCmsModel<CarouselCMSModel> {
  final List<NewsSourceCMSModel>? newsSources;

  const CarouselCMSModel({this.newsSources}) : super();

  static final register = CmsModelProtocol.registerModel<CarouselCMSModel>(() => CarouselCMSModel());

  @override
  final String contentType = 'carouselNewsSources';

  @override
  String fieldsQuery() {
    final String newsSourceContentType = CmsModelProtocol.contentTypeOf<NewsSourceCMSModel>();
    final String newsSourceFieldsQuery = CmsModelProtocol.fieldsQueryOf<NewsSourceCMSModel>();

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
  CmsModelProtocol fromJson(Map<String, dynamic> json) {
    final String newsSourceContentType = CmsModelProtocol.contentTypeOf<NewsSourceCMSModel>();

    final List<dynamic>? items =
    json['${newsSourceContentType}sCollection']?['items'] as List<dynamic>?;

    return CarouselCMSModel(
      newsSources: items
          ?.map(
            (item) => CmsModelProtocol.fromJsonOf<NewsSourceCMSModel>(item as Map<String, dynamic>),
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