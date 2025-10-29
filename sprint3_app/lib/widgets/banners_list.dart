import 'package:flutter/material.dart';
import 'package:sprint3_app/models/banner_dto_model.dart';
import 'package:sprint3_app/widgets/banner_item.dart';

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
        itemCount: banners.length,
        itemBuilder: (context, index) {
          final banner = banners[index];

          return BannerItem(
            banner: banner,
            onTap: () {
              if (onTap != null) {
                onTap!(banner);
              }
            },
          );
        },
      ),
    );
  }
}
