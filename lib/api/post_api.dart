import 'package:demo_app/data/model/post_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'post_api.g.dart';

@RestApi(baseUrl: "https://core-testing.sentrip.vn/api/v1/moment/post")
abstract class PostApi {
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  @GET("/page")
  Future<PostResponse> getPosts({
    @Query("page") required int page,
    @Query("size") required int size,
  });
}
