import 'package:sprint3_app/helpers/string_extension.dart';
import 'package:sprint3_app/models/cms/banner_cms_model.dart';
import 'package:sprint3_app/models/cms/carousel_cms_model.dart';
import 'package:sprint3_app/models/cms/cms_model.dart';
import 'package:sprint3_app/models/cms/news_source_cms_model.dart';

class HomeCMSModel extends AutoRegisterCmsModel<HomeCMSModel>  {
  final String? title;
  final CarouselCMSModel? carousel;
  final List<BannerCMSModel>? banners;

  const HomeCMSModel({this.title, this.carousel, this.banners}) : super();

  static final register = CmsModelProtocol.registerModel<HomeCMSModel>(() => HomeCMSModel());
  
  static registerChildren() {
    register;
    CarouselCMSModel.register;
    BannerCMSModel.register;
    NewsSourceCMSModel.register;
  }

  @override
  final String contentType = 'home';

  @override
  String fieldsQuery() {
    final String carouselContentType = CmsModelProtocol.contentTypeOf<CarouselCMSModel>();
    final String carouselFieldsQuery = CmsModelProtocol.fieldsQueryOf<CarouselCMSModel>();

    final String bannerContentType = CmsModelProtocol.contentTypeOf<BannerCMSModel>();
    final String bannerFieldsQuery = CmsModelProtocol.fieldsQueryOf<BannerCMSModel>();

    return '''
      title
      carousel {
        ... on ${carouselContentType.capitalize()} {
          $carouselFieldsQuery
        }
      }
      ${bannerContentType}sCollection {
        items {
          ... on ${bannerContentType.capitalize()} {
            $bannerFieldsQuery
          }
        }
      }
    ''';
  }

  @override
  HomeCMSModel fromJson(Map<String, dynamic> json) {
    final String bannerContentType = CmsModelProtocol.contentTypeOf<BannerCMSModel>();

    final List<dynamic>? items = json['${bannerContentType}sCollection']?['items'] as List<dynamic>?;

    return HomeCMSModel(
      title: json['title'] as String?,
      carousel: json['carousel'] == null
          ? null
          : CmsModelProtocol.fromJsonOf<CarouselCMSModel>(json['carousel']),
      banners: items
          ?.map(
            (item) => CmsModelProtocol.fromJsonOf<BannerCMSModel>(item as Map<String, dynamic>)
          )
          .toList()
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'carousel': carousel?.toJson(),
    'banners': banners
  };

  @override
  List<Object?> get props => [title, carousel, banners];
}