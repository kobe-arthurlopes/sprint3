import 'package:flutter/material.dart';
import 'package:sprint3_app/components/model_image_widget.dart';
import 'package:sprint3_app/models/dto/article_dto.dart';
import 'package:sprint3_app/web_view/presentation/pages/web_view_page.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/components/shimmer_widget.dart';

class ArticleTile extends StatelessWidget {
  final ArticleDTO? article;

  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final Size size = Size(150, 150);

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ModelImageWidget(
              imageUrl: article?.urlToImage, 
              size: size, 
              placeholder: ShimmerWidget.rectangular(
                width: size.width,
                height: size.height,
                borderRadius: 16,
              )
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: SizedBox(
              height: size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 8),

                  ...
                  article == null
                    ? _buildDetailsShimmers()
                    : _buildArticleDetails(
                      () {
                        Navigator.of(context).pushNamed(
                          WebViewPage.routeId,
                          arguments: article!.url,
                        );
                      }
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildDetailsShimmers() {
    return [
      ShimmerWidget.rectangular(height: 50),

      Padding(
        padding: const EdgeInsets.only(
          right: 40,
          bottom: 8
        ),
        child: ShimmerWidget.rectangular(height: 20),
      ),

      Padding(
        padding: const EdgeInsets.only(
          right: 50,
          bottom: 6
        ),
        child: ShimmerWidget.rectangular(height: 16),
      )
    ];
  }

  List<Widget> _buildArticleDetails(VoidCallback? onTap) {
    return [
      Text(
        article!.title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
        ),
        maxLines: 4,
        textAlign: TextAlign.left,
      ),

      Text(
        article!.author,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w300,
          color: AppColors.tertiary,
        ),
        maxLines: 2,
      ),

      SizedBox(height: 8),

      Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            if (onTap != null) {
              onTap();
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Visit website',
                style: TextStyle(
                  color: AppColors.link,
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                ),
              ),

              SizedBox(width: 4),

              Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Icon(
                  Icons.open_in_new,
                  color: AppColors.link,
                  size: 8,
                ),
              ),
            ],
          ),
        ),
      ),

      SizedBox(height: 6)
    ];
  }
}
