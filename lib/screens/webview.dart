import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SubPage extends StatelessWidget {
  SubPage(this.text, {required Key key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebView')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(text)),
      ),
    );
  }
}
