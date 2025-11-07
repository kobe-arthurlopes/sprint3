import 'package:equatable/equatable.dart';

abstract class CmsModelProtocol {
  String get contentType;
  String fieldsQuery();
  CmsModelProtocol fromJson(Map<String, dynamic> json);

  static final Map<Type, CmsModelProtocol Function()> _registry = {};

  static void registerModel<T>(CmsModelProtocol Function() creator) {
    _registry[T] = creator;
  }

  static String contentTypeOf<T extends CmsModelProtocol>() {
    final model = _registry[T]?.call();

    if (model == null) {
      throw Exception('No contentType registered for $T');
    }

    return model.contentType;
  }

  static String fieldsQueryOf<T extends CmsModelProtocol>() {
    final model = _registry[T]?.call();

    if (model == null) {
      throw Exception('No fieldsQuery registered for $T');
    }

    return model.fieldsQuery();
  }
  
  static T fromJsonOf<T extends CmsModelProtocol>(Map<String, dynamic> json) {
    final creator = _registry[T];

    if (creator == null) {
      throw Exception('No registered model for $T');
    }

    return creator().fromJson(json) as T;
  }
}

abstract class AutoRegisterCmsModel<T extends CmsModelProtocol>
    extends Equatable
    implements CmsModelProtocol {

    const AutoRegisterCmsModel();
}