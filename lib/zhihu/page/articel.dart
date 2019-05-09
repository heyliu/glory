import 'dart:convert';
import 'package:glory/zhihu/model/response.dart' show Article;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:glory/zhihu/api/api.dart';

class ArticleDetail extends StatefulWidget {
  final int id;

  ArticleDetail(this.id);

  @override
  State<StatefulWidget> createState() {
    return ArticleState(id);
  }
}

class ArticleState extends State<ArticleDetail> {
  final int id;
  Article _article;

  WebViewController _webViewController;

  ArticleState(this.id);

  @override
  void initState() {
    _getArticle();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('详情页面'),
      ),
      body: _getColumn()
    );
  }


  _getColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: _article == null
          ? <Widget>[]
          : <Widget>[
        Stack(
          alignment: Alignment(-0.5, 0.8),
          children: <Widget>[
            Image.network(_article.image, width: double.infinity,height: 200,fit: BoxFit.fitWidth,),
            Text(
              _article.title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ],
        ),
        Expanded(
            flex: 1,
            child:_getWebView()
        )
        //getWebView()
      ],
    );
  }

  Widget _getBody(){
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: _getColumn(),
          ),
        );
      },
    );
  }

  WebView _getWebView() {
    return WebView(
      onWebViewCreated: (controller) {
        _webViewController = controller;
        _webViewController.loadUrl(buildUri().toString());
      },
      navigationDelegate: (request){
        return NavigationDecision.navigate;
      },
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (url) {},
    );
  }

  Uri buildUri() {
    return Uri.dataFromString(
      _article.body,
      mimeType: "text/html",
      encoding: Encoding.getByName("utf-8"),
    );
  }

  _getArticle(){
    try {
      Api.get().getArticle(id)
          .catchError((err) {print("请求失败" + err.toString());}, test: (obj) => true)
          .then((data) {
            setState(() {
              _article = data;
            });
          }, );
    } catch (e) {
      print(e.toString());
    }
  }







}
