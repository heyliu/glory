import 'package:flutter/material.dart';
import 'response.dart';
import 'dart:convert';
import 'dart:io';

class ZhihuDaily extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

class ZhihuDailyState extends State<ZhihuDaily> {
  final storyList = <Story>[];
  String date;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, pos) {});
  }
}

class ListItem extends StatelessWidget {
  final String image;
  final String _title;
  final String _id;

  const ListItem(this._title, this._id, {this.image = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: <Widget>[
          Expanded(child: (Image.network(image))),
          Expanded(
            child: Column(
              children: <Widget>[Text(_title)],
            ),
            flex: 3,
          )
        ],
      ),
    );
  }
}


getStories() async {
  try{
    var httpClient = new HttpClient();
    var uri = Uri.parse("https://news-at.zhihu.com/api/4/news/latest");
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    if(response.statusCode == HttpStatus.ok){
      Map map = await response.transform(Utf8Decoder())
          .join().asStream().where((s) => s!= null)
          .map(jsonDecode).first;
      List jsonList = map["stories"];
      List<Story> stroyList = jsonList.fold(<Story>[], (list,map){
        list.add(Story.fromJson(map));
        return list;
      });
      print(stroyList);
    }else{
      print("请求失败");
    }
  }catch(e){
    print(e.toString());
  }
}





