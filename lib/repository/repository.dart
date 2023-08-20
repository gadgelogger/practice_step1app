import 'package:step1/service/repository_api_client.dart';

class Repository {
  final api = Client();
  dynamic fetchList() async {
    return await api.fetchList();
  }
}