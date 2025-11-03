import 'package:flutter/material.dart';
import 'package:sprint3_app/models/dto/banner_dto_model.dart';
import 'package:sprint3_app/widgets/banner_tile.dart';

class BannersList extends StatelessWidget {
  final List<BannerDTOModel> banners;
  final void Function(BannerDTOModel)? onTap;

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
