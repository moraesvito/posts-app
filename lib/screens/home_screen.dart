import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/bloc/post_bloc/post_bloc.dart';
import 'package:posts_app/bloc/post_bloc/post_event.dart';
import 'package:posts_app/screens/widgets/post_list.dart';
import '../repositories/post_repository.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Blog'),
      ),
      body: BlocProvider(
        create: (context) => PostBloc(PostRepository(client: http.Client()))..add(FetchPosts()),
        child: const BlogPage(),
      ),
    );
  }
}

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Blog', style: Theme.of(context).textTheme.headlineMedium),
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        const Expanded(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: 'Posts'),
                    Tab(text: 'Tab'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      PostList(),
                      Center(child: Text('Tab content.')),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
