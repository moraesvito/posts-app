import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/bloc/post_bloc/post_bloc.dart';
import 'package:posts_app/bloc/post_bloc/post_event.dart';
import 'package:posts_app/bloc/post_bloc/post_state.dart';
import 'package:posts_app/screens/widgets/post_card.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  PostListState createState() => PostListState();
}

class PostListState extends State<PostList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      context.read<PostBloc>().add(FetchPosts());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostLoading && state.existingPosts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PostLoaded || (state is PostLoading && state.existingPosts.isNotEmpty)) {
          final posts = state is PostLoaded ? state.posts : (state as PostLoading).existingPosts;
          return ListView.builder(
            controller: _scrollController,
            itemCount: posts.length + 1,
            itemBuilder: (context, index) {
              if (index == posts.length) {
                return const Center(child: CircularProgressIndicator());
              }
              return PostCard(post: posts[index]);
            },
          );
        } else if (state is PostError) {
          return const Center(child: Text('Error when loading posts.'));
        }
        return Container();
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
