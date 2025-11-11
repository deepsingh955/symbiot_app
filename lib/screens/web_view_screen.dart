import 'package:flutter/material.dart';
import 'package:symbiot_app/services/server_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => isLoading = true),
          onPageFinished: (_) => setState(() => isLoading = false),
          onWebResourceError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load: ${error.description}')),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(ServerConfig.baseUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No AppBar here
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (isLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:logi_fin/services/server_config.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
//
// class WebViewScreen extends StatefulWidget {
//   const WebViewScreen({super.key});
//
//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }
//
// class _WebViewScreenState extends State<WebViewScreen> {
//   late final WebViewController _controller;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Use platform-specific creation params for flexibility
//     late final PlatformWebViewControllerCreationParams params;
//
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       // iOS / macOS
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//       );
//     } else {
//       // Android
//       params = AndroidWebViewControllerCreationParams();
//     }
//
//     final controller = WebViewController.fromPlatformCreationParams(params);
//
//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (_) => setState(() => isLoading = true),
//           onPageFinished: (_) => setState(() => isLoading = false),
//           onWebResourceError: (error) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Failed to load: ${error.description}')),
//             );
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(ServerConfig.baseUrl));
//
//     // ✅ Handle SSL certificate errors (Android only)
//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController)
//           .setOnReceivedSslError((controller, handler, error) {
//         // ⚠️ Allow loading even if SSL is invalid — only for testing
//         handler.proceed();
//       });
//     }
//
//     _controller = controller;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // No AppBar — using SafeArea to avoid overlap with status bar
//       body: SafeArea(
//         child: Stack(
//           children: [
//             WebViewWidget(controller: _controller),
//             if (isLoading)
//               const Center(child: CircularProgressIndicator()),
//           ],
//         ),
//       ),
//     );
//   }
// }
