import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sprint3_app/service/app_cache_manager.dart';
import 'package:sprint3_app/theme/image_paths.dart';

class ModelImageWidget extends StatefulWidget {
  final String? imageUrl;
  final Size size;
  final Widget placeholder;
  final Duration timeoutDuration;

  const ModelImageWidget({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.placeholder,
    this.timeoutDuration = const Duration(seconds: 5),
  });

  @override
  State<StatefulWidget> createState() => _ModelImageWidgetState();
}

class _ModelImageWidgetState extends State<ModelImageWidget> {
  bool _timeoutReached = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer(widget.timeoutDuration, () {
      if (mounted) {
        setState(() => _timeoutReached = true);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_timeoutReached && (widget.imageUrl == null || widget.imageUrl!.isEmpty)) {
      return _buildFallbackImage();
    }

    return CachedNetworkImage(
      imageUrl: widget.imageUrl ?? '',
      cacheManager: AppCacheManager().cacheManager,
      width: widget.size.width,
      height: widget.size.height,
      fit: BoxFit.cover,
      placeholder: (_, __) => widget.placeholder,
      errorWidget: (_, __, ___) => widget.placeholder,
    );
  }

  Widget _buildFallbackImage() {
    return Image.asset(
      AppImagePaths.placeholder,
      width: widget.size.width,
      height: widget.size.height,
      fit: BoxFit.cover,
    );
  }
}