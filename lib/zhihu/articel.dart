import 'dart:convert';
import 'dart:io';
import 'response.dart';
import 'package:flutter/material.dart';

class ArticleDetail extends StatefulWidget{

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

  ArticleState(this.id);

  @override
  void initState() {
    getArticle();
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: new Text('详情页面'),),
      body: Column(

        children: _article == null? <Widget>[] : <Widget>[
          Stack(
            alignment: Alignment(-0.5, 0.8),
            children: <Widget>[
              Image.network(_article.image),
              Text(_article.title, style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold,
                fontSize: 22
              ),)

            ],

          )


        ],
      ),
    );
  }


  getArticle() async {
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


