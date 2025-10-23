import 'package:flutter/material.dart';
import 'package:sprint3_app/view_models/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _viewModel.start();
    await _viewModel.fetchNewsSources();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeData>(
      valueListenable: _viewModel.homeData, 
      builder: (_, data, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("News"),
          ),
          body: ListView.builder(
            itemCount: data.newsSources.length,
            itemBuilder: (context, index) {
              final newsSource = data.newsSources[index];

              return Container(
                color: Colors.greenAccent,
                margin: const EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        newsSource.fields?.logoUrl ?? '',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                
                    Text(
                      newsSource.fields?.name ?? 'none',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 40
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}