import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class DisplayWebPage extends StatefulWidget {
  DisplayWebPage({Key? key, required this.link, required this.pageName})
      : super(key: key);
  final String pageName;
  final String link;

  @override
  _DisplayWebPageState createState() => _DisplayWebPageState();
}

class _DisplayWebPageState extends State<DisplayWebPage> {
  late WebViewXController webviewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageName),
      ),
      body: WebViewX(
        initialContent: widget.link,
        initialSourceType: SourceType.URL,
      ),
    );
  }
}
