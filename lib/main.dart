import 'package:flutter/material.dart';
import 'package:symbiot_app/screens/web_view_screen.dart';

void main() {
  runApp(const MyWebsiteApp());
}

class MyWebsiteApp extends StatelessWidget {
  const MyWebsiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebViewScreen(),
    );
  }
}
