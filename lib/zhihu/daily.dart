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





get() async {
  try{
    var httpClient = new HttpClient();
    var uri = new Uri.http(
        'example.com', '/path1/path2', {'param1': '42', 'param2': 'foo'});
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    if(response.statusCode == HttpStatus.ok){
      var json = await response.transform(Utf8Decoder()).transform(StreamTransformer<String,Strory>)join();

    }



  }catch(e){

  }

}

