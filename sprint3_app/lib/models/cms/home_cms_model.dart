import 'package:sprint3_app/helpers/string_extension.dart';
import 'package:sprint3_app/models/cms/carousel_cms_model.dart';
import 'package:sprint3_app/models/cms/cms_model.dart';
import 'package:sprint3_app/models/cms/news_source_cms_model.dart';

class HomeCMSModel extends AutoRegisterCmsModel<HomeCMSModel>  {
  final String? title;
  final CarouselCMSModel? carousel;

  const HomeCMSModel({this.title, this.carousel}) : super();

  static final register = CmsModel.registerModel<HomeCMSModel>(() => HomeCMSModel());
  
  static registerChildren() {
    register;
    CarouselCMSModel.register;
    NewsSourceCMSModel.register;
  }

  @override
  final String contentType = 'home';

  @override
  String fieldsQuery() {
    final carouselContentType = CmsModel.contentTypeOf<CarouselCMSModel>();
    final carouselFieldsQuery = CmsModel.fieldsQueryOf<CarouselCMSModel>();

    return '''
      title
      carousel {
        ... on ${carouselContentType.capitalize()} {
          $carouselFieldsQuery
        }
      }
    ''';
  }

  @override
  HomeCMSModel fromJson(Map<String, dynamic> json) {
    return HomeCMSModel(
      title: json['title'] as String?,
      carousel: json['carousel'] == null
          ? null
          : CmsModel.fromJsonOf<CarouselCMSModel>(json['carousel']),
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'carousel': carousel?.toJson()
  };

  @override
  List<Object?> get props => [carousel, title];
}