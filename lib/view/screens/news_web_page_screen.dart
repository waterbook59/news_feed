import 'package:flutter/material.dart';
import 'package:newsfeed/models/model/news_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebPageScreen extends StatelessWidget {
  final Article article;

  NewsWebPageScreen({@required this.article});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(article.title),centerTitle: true,),
        body: WebView(
          initialUrl: article.url,
          //表示させたurlでjavascript使える
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
