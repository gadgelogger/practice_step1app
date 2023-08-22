import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

//WebViewを表示するためのファイル
class SubPage extends StatefulWidget {
  SubPage(this.text, {super.key});
  String text;

  @override
  State<SubPage> createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebView')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.text)),
      ),
    );
  }
}
