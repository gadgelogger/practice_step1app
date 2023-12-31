//説明１：とりまAPIから取得したい要素のクラスを作成する
//todo:freezedで構築すること！
class Post {
  final String login;
  final String url;
  final String avater;
  final String id;

  Post(
      {required this.login,
      required this.url,
      required this.avater,
      required this.id});

  factory Post.fromJson(Map<String, dynamic> json) {
    //ここで処理を行い[Post]で返す
    return Post(
      login: json['login'],
      url: json['html_url'],
      avater: json['avatar_url'],
      id: json['id'].toString(),
    );
  }
}
