import 'dart:convert';
import 'dart:io';
import 'response.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
//            child: Column(
//              mainAxisSize: MainAxisSize.min,
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: <Widget>[
//                Container(
//                  // A fixed-height child.
//                  color: const Color(0xff808000), // Yellow
//                  height: 120.0,
//                ),
//                Container(
//                  // Another fixed-height child.
//                  color: const Color(0xff008000), // Green
//                  height: 120.0,
//                ),
//              ],
//            ),
          ),
        );
      },
    );
  }

  WebView _getWebView() {
    return WebView(
      onWebViewCreated: (controller) {
        _webViewController = controller;
        _webViewController.loadUrl(buildlUri().toString());
      },
      navigationDelegate: (request){
        return NavigationDecision.navigate;
      },
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (url) {},
    );
  }

  Uri buildlUri() {
    return Uri.dataFromString(
      _article.body,
      mimeType: "text/html",
      encoding: Encoding.getByName("utf-8"),
    );
  }

  _getArticle() async {
    try {
      var httpClient = new HttpClient();
      var uri = Uri.parse("https://news-at.zhihu.com/api/4/news/$id");
      var request = await httpClient.getUrl(uri);
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        Map map = await response
            .transform(Utf8Decoder())
            .join()
            .asStream()
            .map((s){
              print(s);
              return s;
            })
            .where((s) => s != null)
            .map(jsonDecode)
            .first;
        setState(() {
          _article = Article.fromJson(map);
        });
      } else {
        print("请求失败");
      }
    } catch (e) {
      print(e.toString());
    }
  }







}
