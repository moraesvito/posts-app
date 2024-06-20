import 'package:posts_app/models/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {
  final List<Post> existingPosts;
  PostLoading(this.existingPosts);
}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);
}

class PostError extends PostState {}

