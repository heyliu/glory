import 'dart:convert';
import 'dart:io';
import 'package:glory/zhihu/model/response.dart';

typedef R OnValue<T,R>  (T data);

abstract class Api {
  static _ApiImp _instance;

  static Api get() {
    if (_instance == null) {
      _instance = _ApiImp();
    }
    return _instance;
  }

  final _httpClient = new HttpClient();

  
  Future<Article> getArticle(int id){
    var uri = Uri.parse("https://news-at.zhihu.com/api/4/news/$id");
    return _requestFormMap(uri).then((value) => Article.fromJson(value));
  }


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



  Future<Map> _requestFormMap(Uri url) {
    return _requestJson(url).then((json){
      if(json != null){
        return jsonDecode(json);
      }else{
        return null;
      }
    });
  }

  Future<String> _requestJson(Uri url) {
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

