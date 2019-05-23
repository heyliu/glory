import 'package:flutter/material.dart';
import 'articel.dart';
import 'package:glory/zhihu/model/response.dart';
import 'package:glory/zhihu/api/api.dart';

class ZhihuDaily extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ZhihuDailyState();
  }
}
//推荐列表
class ZhihuDailyState extends State<ZhihuDaily> {
  var _storyList = <Story>[];

  @override
  void initState() {
    getStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('Startup Name Generator'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        itemBuilder: (context, pos) {
          var story = _storyList[pos];
          var img = (story.images != null && story.images.length > 0) ? story.images[0] : null;
          return ListItem(story.title, story.id, image: img);
        },
        itemCount: _storyList.length,
        semanticChildCount: _storyList.length,
      ),
    );
  }
  ///网络请求
  getStories() async {
    try {
      Api.get().getStories().then((data){
        setState(() {
          _storyList = data;
        });
      }).catchError((obj){
        if(obj is Exception){

        }
        print("请求失败： " + obj.toString());
        throw obj;
      },test: (obj) => true);
    } catch (e) {
      print(e.toString());
    }
  }
}

///list item
class ListItem extends StatelessWidget {
  final String image;
  final String _title;
  final int _id;

  const ListItem(this._title, this._id, {this.image = ""});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){_viewDetail(context);},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: (Image.network(image))),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    _title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15, height: 1.2),
                  ),
                ),
                flex: 3,
              )
            ],
          ),
        ));
  }

  _viewDetail(BuildContext context) {
    Navigator.push(context,MaterialPageRoute(builder: (context) => ArticleDetail(_id)));
  }
}
