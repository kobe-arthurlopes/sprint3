import 'package:equatable/equatable.dart';

abstract class CmsModel {
  String get contentType;
  String fieldsQuery();
  CmsModel fromJson(Map<String, dynamic> json);

  static final Map<Type, CmsModel Function()> _registry = {};

  static void registerModel<T>(CmsModel Function() creator) {
    _registry[T] = creator;
  }

  static String contentTypeOf<T extends CmsModel>() {
    final model = _registry[T]?.call();

    if (model == null) {
      throw Exception('No contentType registered for $T');
    }

    return model.contentType;
  }

  static String fieldsQueryOf<T extends CmsModel>() {
    final model = _registry[T]?.call();

    if (model == null) {
      throw Exception('No fieldsQuery registered for $T');
    }

    return model.fieldsQuery();
  }
  
  static T fromJsonOf<T extends CmsModel>(Map<String, dynamic> json) {
    final creator = _registry[T];

    if (creator == null) {
      throw Exception('No registered model for $T');
    }

    return creator().fromJson(json) as T;
  }
}

abstract class AutoRegisterCmsModel<T extends CmsModel>
    extends Equatable
    implements CmsModel {

    const AutoRegisterCmsModel();
}