import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hundalstore/no_internet_page.dart';
import 'package:hundalstore/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = 'https://www.hundaldental.com/';
  late WebViewController _webViewController;
  bool _isConnected = false;

  @override
  void initState() {
    initailizeWebView();
    _checkConnectivity();
    super.initState();
  }

  // Future<void> _handleDeepLink() async {
  //   try {
  //     // Handle the link when the app is launched from a cold start
  //     final initialLink = await getInitialLink();
  //     if (initialLink != null) {
  //       _processLink(initialLink);
  //     }

  //     // Handle the link when the app is resumed from background
  //     linkStream.listen((String? link) {
  //       if (link != null) {
  //         _processLink(link);
  //       }
  //     });
  //   } on PlatformException catch (e) {
  //     print('Failed to get initial link: $e');
  //   }
  // }

  // void _processLink(String link) {
  //   print('Received deep link: $link');
  //   // Navigate to the appropriate page based on the link
  // }

  initailizeWebView() async {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _isConnected
              ? WebViewPage(controller: _webViewController)
              : NoInternet(controller: _webViewController)),
    );
  }
}
