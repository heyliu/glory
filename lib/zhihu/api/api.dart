import 'dart:convert';
import 'dart:io';
import 'package:glory/zhihu/model/response.dart';

typedef R OnValue<T,R>  (T data);
///所有的网络请求，只有静态方法
abstract class Api {
  static _ApiImp _instance;

  ///单例
  static Api get() {
    if (_instance == null) {
      _instance = _ApiImp();
    }
    return _instance;
  }

  final _httpClient = new HttpClient();

  ///文章详情
  Future<Article> getArticle(int id){
    var uri = Uri.parse("https://news-at.zhihu.com/api/4/news/$id");
    return _requestFormMap(uri).then((value) => Article.fromJson(value));
  }

  ///请求信息流
  Future<List<Story>> getStories() {
    var uri = Uri.parse("https://news-at.zhihu.com/api/4/news/latest");
    OnValue<Map, List<Story>> jsonParse = (map) {
      List data = map["stories"];
      return data.fold(<Story>[], (list, m) {
        list.add(Story.fromJson(m));
        return list;
      });
    };
    return _requestFormMap(uri).then(jsonParse);
  }




  Future<String> getString(Uri url){
    return _requestString(url);
  }


  Future<Map> _requestFormMap(Uri url) {
    return _requestString(url).then((json){
      if(json != null){
        return jsonDecode(json);
      }else{
        return null;
      }
    });
  }

  Future<String> _requestString(Uri url) {
    return _httpClient.getUrl(url)
        .then((request) => request.close())
        .then((response) {
          if(response.statusCode == HttpStatus.ok){
            return response.transform(Utf8Decoder());
          }else{
            throw HttpException("网络异常", uri: url);
          }
        }).then((data) => data.join());
  }
}


class _ApiImp extends Api {}


