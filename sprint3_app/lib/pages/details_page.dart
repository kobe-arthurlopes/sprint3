import 'package:flutter/material.dart';
import 'package:sprint3_app/view_models/home_view_model.dart';

class DetailsPage extends StatefulWidget {
  static const routeId = '/details';

  final HomeViewModel viewModel;

  const DetailsPage({super.key, required this.viewModel});

  @override
  State<StatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeData>(
      valueListenable: widget.viewModel.homeData,
      builder: (_, data, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(data.selectedNewsSource?.fields?.name ?? 'empty'),
          ),
          body: ListView.builder(
            itemCount: data.articles.length,
            itemBuilder: (context, index) {

            },
          ),
        );
      },
    );
  }
}