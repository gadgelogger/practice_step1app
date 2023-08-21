class Post {
  final String login; //リポジトリ名
  final String url; //リポジトリの説明
  final String avater;

  Post({required this.login, required this.url, required this.avater});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      login: json['login'],
      url: json['html_url'],
      avater: json['avatar_url'],
    );
  }
}
