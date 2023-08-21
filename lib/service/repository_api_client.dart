import 'package:dio/dio.dart';
import 'package:step1/model/post.dart';

//APIの取得を行うファイル

Future<List<Post>?> fetchList(int since) async {
  final dio = Dio();
  final url = 'https://api.github.com/users?per_page=20&since=$since';

  final response = await dio.get(url);

  if (response.statusCode == 200) {
    try {
      final datas = response.data as List<dynamic>;
      final list = datas.map((e) => Post.fromJson(e)).toList();
      return list;
    } catch (e) {
      rethrow;
    }
  }
  return null;
}
