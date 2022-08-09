import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RealEstateWebView extends StatefulWidget {
  final String pageUrl;
  final String title;

  const RealEstateWebView(
      {Key? key, required this.pageUrl, required this.title})
      : super(key: key);

  @override
  RealEstateWebViewState createState() => RealEstateWebViewState();
}

class RealEstateWebViewState extends State<RealEstateWebView> {
  @override
  void initState() {
    super.initState();
  }

  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.pageUrl,
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) async {
              return NavigationDecision.navigate;
            },
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}
