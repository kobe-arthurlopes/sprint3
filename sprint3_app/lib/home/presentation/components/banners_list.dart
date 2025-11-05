import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dto/banner_dto.dart';
import 'package:sprint3_app/home/presentation/components/banner_tile.dart';

class BannersList extends StatelessWidget {
  final List<BannerDTO> banners;
  final void Function(BannerDTO)? onTap;

  const BannersList({super.key, required this.banners, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: banners.isEmpty ? 10 : banners.length,
        itemBuilder: (context, index) {
          return BannerTile(
            banner: banners.isEmpty ? null : banners[index],
            onTap: () {
              if (onTap != null && banners.isNotEmpty) {
                onTap!(banners[index]);
              }
            },
          );
        },
      ),
    );
  }
}
