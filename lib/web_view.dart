import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hundalstore/unable_load.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final WebViewController controller;
  const WebViewPage({super.key, required this.controller});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool _isLoading = true;
  int loadingPercentage = 0;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    widget.controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) async {
          setState(() {
            _isLoading = true;
            loadingPercentage = progress;
          });
          print(progress);
        },
        onUrlChange: (url) {
          log('url chnaged ${url.url}'); // setState(() {
          //   _isLoading = false;
          // });
        },
        onPageStarted: (String url) {
          setState(() {
            _isLoading = true;
            loadingPercentage = 0;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            _isLoading = false;
            loadingPercentage = 100;
          });
        },
        onHttpError: (HttpResponseError error) {
          log('http error $error');
        },
        onWebResourceError: (WebResourceError error) {
          log('web error ${error.description}');
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const UnableToLoad()));
        },
        onNavigationRequest: (NavigationRequest request) async {
          if (request.url.startsWith('tel:') ||
              request.url.startsWith('mailto:') ||
              request.url.startsWith('whatsapp:') ||
              request.url.startsWith('facebook:') ||
              request.url.startsWith('https://m.facebook.com/') ||
              request.url.startsWith('https://api.whatsapp.com/') ||
              request.url.startsWith('https://www.instagram.com/') ||
              request.url.contains('whatsapp.com') ||
              request.url.contains('instagram.com') ||
              request.url.contains('facebook.com')) {
            await _handleUrl(request.url);

            return NavigationDecision
                .prevent; // Prevent the WebView from navigating
          }
          return NavigationDecision.navigate; // Allow the WebView to navigate
        },
      ),
    );
    super.initState();
  }

  Future<void> _handleUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
      setState(() {
        _isLoading = false;
        loadingPercentage = 100;
      });
    } catch (e) {
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const UnableToLoad()));
      print('Could not launch $url');
    } finally {
      setState(() {
        _isLoading = false;
        loadingPercentage = 100;
      });
    }

    // if (await canLaunchUrl(Uri.parse(url))) {
    //   await launchUrl(Uri.parse(url));
    // } else {
    //   // Handle the error if the URL cannot be launched
    //   print('Could not launch $url');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: widget.controller),
        if (loadingPercentage < 100)
          Center(
            child: OverlayLoaderWithAppIcon(
              circularProgressColor: const Color(0xffffd333),
              isLoading: _isLoading,
              overlayOpacity: 0.65,
              appIconSize: 100,
              overlayBackgroundColor: Colors.black45,
              appIcon: Image.asset('assets/hundal_logo.png'),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const Center(child: CircularProgressIndicator()),
                  // Text(
                  //   'Loading $loadingPercentage...',
                  //   style: const TextStyle(fontSize: 20),
                  // ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text(
                "  Loading...",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
              )),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
