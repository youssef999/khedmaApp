import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khedma/Utils/utils.dart';
import 'package:screenshot/screenshot.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key, required this.url});
  final String url;
  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {
  late final WebViewController controller;
  int i = 0;
  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            logSuccess("progress is : $progress");
          },
          onPageStarted: (String url) {
            logSuccess("page started : $url");
            if (url.startsWith('https://khdmah.online/api')) {
              i = 1;
            }
          },
          onPageFinished: (String url) {
            logSuccess("page finished : $url");
            if (url.startsWith('https://khdmah.online/api')) {
              if (i == 1) Get.back();
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://khdmah.online/api')) {
            //   if(request)
            // return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    // #enddocregion webview_controller
  }

  ScreenshotController scontroller = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: scontroller,
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Utils.takeContainer(scontroller, "pay.png");
            },
            child: Text('pay'.tr),
          ),
        ),
        body: WebViewWidget(controller: controller),
      ),
    );
  }
}
