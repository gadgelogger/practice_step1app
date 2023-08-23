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
    return Post(
      login: json['login'],
      url: json['html_url'],
      avater: json['avatar_url'],
      id: json['id'].toString(),
    );
  }
}
