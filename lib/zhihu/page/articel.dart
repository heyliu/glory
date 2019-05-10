import 'dart:convert';
import 'package:glory/zhihu/model/response.dart' show Article;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:glory/zhihu/api/api.dart';
import "dart:async";

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
  String cssStyleJs;
  String imgHolderJs;

  WebViewController _webViewController;
  ArticleState(this.id);

  var _articleCompleter = new Completer<Article>();

  @override
  void initState() {
    _getArticle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Text('详情页面'),
          ),
          body: _getWebView()),
      onWillPop: _requestPop,
    );
  }

  Future<bool> _requestPop(){
    var webCanGoBack = _webViewController.canGoBack();
    webCanGoBack.then((b){
      if(b){
        _webViewController.goBack();
      }else{
        Navigator.of(context).pop();
      }
    });
    return webCanGoBack;
  }
  
//
//  _getColumn(){
//    return Column(
//      mainAxisAlignment: MainAxisAlignment.start,
//      mainAxisSize: MainAxisSize.min,
//      children: _article == null
//          ? <Widget>[]
//          : <Widget>[
//        Stack(
//          alignment: Alignment(-0.5, 0.8),
//          children: <Widget>[
//            Image.network(_article.image, width: double.infinity,height: 200,fit: BoxFit.fitWidth,),
//            Text(
//              _article.title,
//              style: TextStyle(
//                  color: Colors.white,
//                  fontWeight: FontWeight.bold,
//                  fontSize: 22),
//            ),
//          ],
//        ),
//        Expanded(
//          flex: 1,
//          child: _getWebView(),
//        )
//        //getWebView()
//      ],
//    );
//  }

  _getWebView() {
    return WebView(
      onWebViewCreated: (controller) {
        _webViewController = controller;
        _articleCompleter.future.then((_article){
          _webViewController.loadUrl(buildUri(_article).toString());
        });
      },
      navigationDelegate: (request){
        return NavigationDecision.navigate;
      },
      javascriptMode: JavascriptMode.unrestricted,
      onPageFinished: (url) {
        _changeStyleByInjectJs();
      },
    );
  }

  _changeStyleByInjectJs() async{
    if(cssStyleJs != null){
       _webViewController.evaluateJavascript(cssStyleJs + imgHolderJs);
    }
//    if(imgHolderJs != null){
//      _webViewController.evaluateJavascript(imgHolderJs);
//    }
  }

  Uri buildUri(Article article) {
    return Uri.dataFromString(
      "<html><body>" + article.body +"</body></html>",
      mimeType: "text/html",
      encoding: Encoding.getByName("utf-8"),
    );
  }

  _getArticle() async{
    Api.get().getArticle(id)
        .catchError((err) {print("请求失败" + err.toString());}, test: (obj) => true)
        .then((data) {
          setState(() {
            _articleCompleter.complete(data);
          });
          var imgUrl = data.image;
          var title = data.title;
          imgHolderJs = "(function(){" +
          "var img = document.getElementsByClassName('img-place-holder');" +
          "img[0].innerHTML='"
              "<img src = \"$imgUrl\" height=\"100%\" width =\"100%\"/>" +
              "<span class =\"my_title_span\">$title<span/>';" +
          "var parent = document.getElementsByTagName('head').item(0);"+
          "var style = document.createElement('style');"+
          "style.type = 'text/css';"+
          "parent.appendChild(style);"+
          "style.innerHTML='span.my_title_span {color: #fff;line-height: 1.2em; font-size: 22px; position: relative; top: -60px; left:20px;}';"+
          "}())";
          return data.css;
          })
        .then(requestCss);
  }


  void requestCss(List<String> css){
    if(css != null && css.isNotEmpty){
      css.forEach((ele){
        Api.get().requestString(Uri.parse(ele))
            .catchError((err) {print("请求失败" + err.toString());}, test: (obj) => true)
            .then((cssStr){
                cssStr = cssStr.replaceAll("\n", "").replaceAll("\"", "\\");
                cssStyleJs = "(function() {" +
                    "console.log('========');"
                    "var parent = document.getElementsByTagName('head').item(0);" +
                    "var style = document.createElement('style');" +
                    "style.type = 'text/css';" +
                    "style.innerHTML = \"$cssStr\";" +
                    "parent.appendChild(style)" +
                    "})()";
            });
      });

    }
  }
}
