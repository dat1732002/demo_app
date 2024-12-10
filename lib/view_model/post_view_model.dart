
import 'package:demo_app/data/model/post_model.dart';
import 'package:demo_app/data/repository/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final postViewModelProvider = StateNotifierProvider<PostViewModel, AsyncValue<List<Content>>>((ref) {
  return PostViewModel(PostRepository(Dio()));
});

class PostViewModel extends StateNotifier<AsyncValue<List<Content>>> {
  final PostRepository _repository;

  PostViewModel(this._repository) : super(const AsyncLoading()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final cachedPosts = await _repository.getCachedPosts();
      if (cachedPosts.isNotEmpty) {
        state = AsyncValue.data(cachedPosts);
      }

      final apiPosts = await _repository.fetchPosts();
      state = AsyncValue.data(apiPosts);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> refreshPosts() async {
    try {
      state = const AsyncLoading();
      final posts = await _repository.fetchPosts();
      state = AsyncValue.data(posts);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
