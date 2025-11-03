import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sprint3_app/service/app_cache_manager.dart';
import 'package:sprint3_app/theme/image_paths.dart';

class ModelImageWidget extends StatelessWidget {
  final String? imageUrl;
  final Size size;

  const ModelImageWidget({super.key, this.imageUrl, required this.size});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return Image.asset(
        AppImagePaths.placeholder,
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      cacheManager: AppCacheManager.instance,
      width: size.width,
      height: size.height,
      fit: BoxFit.cover,
      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget: (_, _, _) => const Icon(Icons.error),
    );
  }
}