import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class livetv extends StatefulWidget {
  const livetv({Key? key}) : super(key: key);

  @override
  _LiveTvState createState() => _LiveTvState();
}

class _LiveTvState extends State<livetv> {
  late WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live TV'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://www.indiatoday.in/livetv',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebViewCreated: (WebViewController webViewController) {
              _webViewController = webViewController;
            },
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
