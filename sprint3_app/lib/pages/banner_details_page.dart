import 'package:flutter/material.dart';
import 'package:sprint3_app/models/banner_dto_model.dart';
import 'package:sprint3_app/widgets/app_bar_widget.dart';

class BannerDetailsPage extends StatefulWidget {
  static const routId = '/banner_details';

  final BannerDTOModel banner;

  const BannerDetailsPage({super.key, required this.banner});

  @override
  State<StatefulWidget> createState() => _BannerDetailsPageState();
}

class _BannerDetailsPageState extends State<BannerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final BannerDTOModel banner = widget.banner;

    return Scaffold(
      backgroundColor: Color(0xFFECEDEF),
      appBar: AppBarWidget(title: banner.title),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  banner.logoUrl ?? '',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover
                ),
              ),
            ),
        
            SizedBox(height: 16),
        
            Text(
              banner.subtitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                // color: Color(0xFF1F1F1F),
                color: Color(0xFF6B7280),
              ),
              textAlign: TextAlign.center,
            ),
        
            SizedBox(height: 16),
        
            Text(
              banner.description,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                // color: Color(0xFF6B7280),
                color: Color(0xFF1F1F1F),
              ),
            )
          ],
        ),
      )
    );
  }
}
