import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dto/banner_dto_model.dart';
import 'package:sprint3_app/theme/colors.dart';
import 'package:sprint3_app/theme/image_paths.dart';
import 'package:sprint3_app/widgets/shimmer_widget.dart';

class BannerTile extends StatelessWidget {
  final BannerDTOModel? banner;
  final VoidCallback? onTap;

  const BannerTile({super.key, required this.banner, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null && banner != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: banner == null
            ? ShimmerWidget.rectangular(
                width: MediaQuery.of(context).size.width - 20,
                height: 250,
                borderRadius: 16,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.network(
                      banner!.logoUrl ?? '',
                      width: MediaQuery.of(context).size.width - 20,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) {
                        return Image.asset(
                          AppImagePaths.placeholder,
                          width: MediaQuery.of(context).size.width - 20,
                          height: 250,
                          fit: BoxFit.cover,
                        );
                      },
                    ),

                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.border,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
