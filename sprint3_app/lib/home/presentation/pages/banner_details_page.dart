import 'package:flutter/material.dart';
import 'package:sprint3_app/common/models/dto/banner_dto.dart';
import 'package:sprint3_app/common/theme/colors.dart';
import 'package:sprint3_app/common/components/app_bar_widget.dart';
import 'package:sprint3_app/common/components/model_image_widget.dart';
import 'package:sprint3_app/common/components/shimmer_widget.dart';

class BannerDetailsPage extends StatelessWidget {
  static const routeId = '/banner_details';

  final BannerDTO banner;

  const BannerDetailsPage({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBarWidget(title: banner.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: ModelImageWidget(
                  imageUrl: banner.logoUrl, 
                  size: Size(200, 200), 
                  placeholder: ShimmerWidget.rectangular(
                    width: 200,
                    height: 200,
                  )
                ),
              ),
            ),

            SizedBox(height: 16),

            Text(
              banner.subtitle,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.tertiary
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16),

            Text(
              banner.description,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
