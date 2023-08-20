import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:step1/model/user.dart';
import 'package:step1/repository/repository.dart';

// Repository(APIの取得)の状態を管理する
final repositoryProvider = Provider((ref) => Repository());

// 上記を非同期で管理する
final listProvider = FutureProvider<List<User>>((ref) async {
  final repository = ref.read(repositoryProvider);
  return await repository.fetchList();
});