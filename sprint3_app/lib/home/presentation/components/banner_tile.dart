import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dto/banner_dto.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/components/model_image_widget.dart';
import 'package:sprint3_app/components/shimmer_widget.dart';

class BannerTile extends StatelessWidget {
  final BannerDTO? banner;
  final VoidCallback? onTap;

  const BannerTile({super.key, required this.banner, this.onTap});

  @override
  Widget build(BuildContext context) {
    final Size size = Size(
      MediaQuery.of(context).size.width - 20,
      250
    );

    return GestureDetector(
      onTap: () {
        if (onTap != null && banner != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              ModelImageWidget(
                imageUrl: banner?.logoUrl, 
                size: size, 
                placeholder: ShimmerWidget.rectangular(
                  width: size.width,
                  height: size.height,
                  borderRadius: 16,
                )
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.border,
                      width: 2
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
