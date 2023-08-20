import 'package:dio/dio.dart';
import 'package:step1/model/user.dart';

class Client {
  Future<List<User>?> fetchList() async {
    final dio = Dio();
    const url = 'https://api.github.com/users';
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      try {
        final datas = response.data as List<dynamic>;
        final list = datas.map((e) => User.fromJson(e)).toList();
        return list;
      } catch (e) {
        throw e;
      }
    }
    return null;
  }
}