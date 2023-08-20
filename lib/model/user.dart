import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// build_runnerを使うことで自動生成されるファイル
part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  factory User({
    String? login,
    String? avatar_url,
    String? html_url,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
