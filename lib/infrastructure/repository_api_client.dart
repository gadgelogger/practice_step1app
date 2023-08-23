import 'package:dio/dio.dart';
import 'package:step1/model/post.dart';

//APIの取得を行うファイル
//書き方はこのサイトを参考https://terupro.net/flutter-api-dio-sample/
class RepositoryApiClient {
  final Dio dio;

  RepositoryApiClient(this.dio);

  Future<List<Post>> fetchList(int since) async {
    final url = 'https://api.github.com/users?per_page=20&since=$since';

    final response = await dio.get(url);
    //正常なリクエストの場合
    if (response.statusCode == 200) {
      try {
        final datas = response.data as List<dynamic>;
        final list = datas.map((e) => Post.fromJson(e)).toList();
        return list;
      } catch (e) {
        rethrow;
      }
    }

    return [];
  }
}
