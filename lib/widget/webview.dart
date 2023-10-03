import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class WebViewPage extends StatefulWidget {
  final bool hideAppBar;
  final String title;
  final String url;
  final Color statusBarColor;

  const WebViewPage(
      {super.key,
      required this.hideAppBar,
      required this.title,
      required this.url,
      required this.statusBarColor});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;
  bool loadFinish = false;

  @override
  void initState() {
// #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              loadFinish = true;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');
            loadFinish = true;
          },
          onNavigationRequest: (NavigationRequest request) {
            // 获取当前WebView的URL
            final currentUrl = widget.url;

            // 检查请求的URL是否与当前URL不同
            //if (request.url != currentUrl) {
            //   debugPrint('Blocking navigation to ${request.url}');
            //   return NavigationDecision.prevent;
            // }

            // 允许加载其他情况下的URL
            debugPrint('Allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      //AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColor = "ffffff";
    Color backButtonColor;
    if (statusBarColor == "ffffff") {
      backButtonColor = Colors.green;
    } else {
      backButtonColor = Colors.red;
    }
    //webview插件
    return Scaffold(
      body: Column(
        children: [
          _appBar(widget.statusBarColor, backButtonColor),
          Expanded(
            child: WebViewWidget(controller: _controller),
          )
        ],
      ),
    );
  }

  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
      child: FractionallySizedBox(
        child: Stack(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.fromLTRB(
                        5, 5, 0, 0), // Adjust the left margin
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: backButtonColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.title ?? "",
                      style: TextStyle(color: backButtonColor, fontSize: 20),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
