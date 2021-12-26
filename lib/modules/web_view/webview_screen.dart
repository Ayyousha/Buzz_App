
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
    final String url;
    final String title;
   WebViewScreen(this.url, this.title);
  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: true,
      builder: (context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red[800],

          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
              title,
          ),
        ),
        // Package WebView
        body: WebView(
          initialUrl: url,
        ),
      ),
      fallback: (context) => Scaffold(
          appBar: AppBar()
          ,body: Center(
          child: CircularProgressIndicator()
       ),
      ),
    );
  }
}
