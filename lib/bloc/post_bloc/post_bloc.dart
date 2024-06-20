import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/models/post.dart';
import 'package:posts_app/repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;
  int _startIndex = 0;
  final int _limit = 10;
  final List<Post> _posts = [];

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPosts>(_onFetchPosts);
  }

  void _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    if (state is PostLoading) return;
    emit(PostLoading(_posts));
    try {
      final posts = await postRepository.fetchPosts(_startIndex, _limit);
      _posts.addAll(posts);
      _startIndex += _limit;
      emit(PostLoaded(_posts));
    } catch (_) {
      emit(PostError());
    }
  }
}
