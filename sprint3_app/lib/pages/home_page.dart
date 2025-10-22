import 'package:flutter/material.dart';
import 'package:sprint3_app/models/blog_post.dart';
import 'package:sprint3_app/service/repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Repository repository = Repository();

  late Future<List<BlogPost>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = repository.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Foo"),
      ),
      body: FutureBuilder(
        future: futurePosts, 
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final posts = snapshot.data!;

            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.fields?.title ?? "empty"),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
      ),
    );
  }
}