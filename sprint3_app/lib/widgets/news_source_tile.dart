import 'package:flutter/material.dart';
import 'package:sprint3_app/models/news_source_dto_model.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/theme/image_paths.dart';
import 'package:sprint3_app/widgets/shimmer_widget.dart';

class NewsSourceTile extends StatelessWidget {
  final NewsSourceDTOModel? newsSource;
  final VoidCallback? onTap;

  const NewsSourceTile({super.key, required this.newsSource, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null && newsSource != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            newsSource == null
              ? ShimmerWidget.circular(radius: 50)
              : ClipOval(
                child: Image.network(
                  newsSource!.logoUrl ?? '',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) {
                    return Image.asset(
                      AppImagePaths.placeholder,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),

            SizedBox(
              width: 100,
              height: 40,
              child: newsSource == null
                ? ShimmerWidget.rectangular()
                : Center(
                  child: Text(
                    newsSource!.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ),
            )
          ],
        ),
      ),
    );
  }
}