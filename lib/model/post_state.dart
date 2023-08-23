import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:step1/model/post.dart';

//自動生成されるファイル
part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  const factory PostState({
    @Default(0) int since, //デフォルト値は1
    List<Post>? posts, //Postクラスのリスト(post.dartで定義したクラス)
    @Default(true) bool isLoading, //デフォルト値はtrue
    @Default(false) bool isLoadMoreError, //デフォルト値はfalse
    @Default(false) bool isLoadMoreDone, //デフォルト値はfalse
  }) = _PostState;

  const PostState._();
}
