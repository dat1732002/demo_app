import 'package:demo_app/view/widget/post_item.dart';
import 'package:demo_app/view_model/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class NewsFeedScreen extends ConsumerWidget {
  const NewsFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postState = ref.watch(postViewModelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('NewsFeed'),
      ),
      body: postState.when(
        data: (posts) => RefreshIndicator(
          color: Colors.pink,
          onRefresh: () => ref.read(postViewModelProvider.notifier).refreshPosts(),
          child: ListView.separated(
            separatorBuilder: (context, index) => Container(
              height: 8,
              color: Colors.black12
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return PostItemWidget(post: posts[index]);
            },
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.pink,)),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
