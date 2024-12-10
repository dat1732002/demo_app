import 'dart:convert';
import 'package:demo_app/api/post_api.dart';
import 'package:demo_app/data/model/post_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepository {
  final PostApi _postApi;
  static const _cacheKey = 'post_cache';

  PostRepository(Dio dio)
      : _postApi = PostApi(dio);

  Future<List<Content>> fetchPosts({int page = 0, int size = 20}) async {
    final response = await _postApi.getPosts(page: page, size: size);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cacheKey, jsonEncode(response.data?.content?.map((e) => e.toJson()).toList()));

    return response.data?.content??[];
  }

  Future<List<Content>> getCachedPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_cacheKey);
    if (cachedData != null) {
      final List<dynamic> jsonData = jsonDecode(cachedData);
      return jsonData.map((e) => Content.fromJson(e)).toList();
    }
    return [];
  }
}
