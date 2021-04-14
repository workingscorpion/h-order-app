import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContent extends StatefulWidget {
  WebViewContent({
    this.contents,
  });

  final String contents;

  @override
  _WebViewContentState createState() => _WebViewContentState();
}

class _WebViewContentState extends State<WebViewContent> {
  WebViewController _controller;
  String url;

  @override
  void initState() {
    super.initState();
    final html = _html();
    final data = base64.encode(utf8.encode(html));
    url = 'data:text/html;base64,$data';
  }

  String _html() {
    final padding = EdgeInsets.only(
      top: 0,
      left: 20,
      right: 20,
      bottom: 100,
    );

    return '''<!DOCTYPE HTML>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

  <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">

  <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

  <style>
    body {
      padding: ${padding.top}px ${padding.right}px ${padding.bottom}px ${padding.left}px;
    }
    img {
      max-width: 100%;
    }
  </style>
</head>

<body>
  <div class="summernote">
    <div class="note-editor">
      <div class="note-editing-area">
        <div class="note-editable">
          <div>${widget.contents}</div>
        </div>
      </div>
    </div>
  </div>
</body>
</html>''';
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
      debuggingEnabled: false,
    );
  }
}
