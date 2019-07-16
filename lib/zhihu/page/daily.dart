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
  var _banners = <BannerStory>[];

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
        body: _createBody());
  }

  _createBody() {
    return ListView.builder(
      itemBuilder: (context, pos) {
        if (pos == 0) {
          return _createImagePager(_banners);
        } else {
          var story = _storyList[pos - 1];
          var img = (story.images != null && story.images.length > 0)
              ? story.images[0]
              : null;
          return ListItem(story.title, story.id, image: img);
        }
      },
      itemCount: _storyList.length + (_banners == null ? 0 : 1),
    );
  }

  Widget _createImagePager(List<BannerStory> imgList) {
    return Container(height: 150, child: _createBanner(imgList));
  }

  _createBanner(List<BannerStory> imgList) {
    var pageController = PageController(initialPage: 0);
    var children = imgList
        .map((item) => Image.network(item.image, fit: BoxFit.cover))
        .toList();
    return PageView(
        controller: pageController,
        children: children,
        onPageChanged: (page) {
          print("onpageChange" + page.toString());
        });
  }

  ///网络请求
  getStories() async {
    try {
      Api.get().getStories().then((data) {
        setState(() {
          _storyList = data.stories;
          _banners = data.topStories;
        });
      }).catchError((obj) {
        if (obj is Exception) {}
        print("请求失败： " + obj.toString());
        throw obj;
      }, test: (obj) => true);
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
        onTap: () {
          _viewDetail(context);
        },
        child: new Padding(
            padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
            child: Card(
              elevation: 5,
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(child: (Image.network(image))),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            _title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 17,
                                height: 1),
                          ),
                        ),
                        flex: 3,
                      )
                    ],
                  )),
            )));
  }

  _viewDetail(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ArticleDetail(_id)));
  }
}
