import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:glory/utils/error.dart';
import 'package:glory/zhihu/model/fir_response.dart';
import 'package:glory/zhihu/model/response.dart';
import 'package:glory/zhihu/page/package.dart';

typedef R OnValue<T, R>(T data);

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
  Future<Article> getArticle(int id) {
    var uri = Uri.parse("https://news-at.zhihu.com/api/4/news/$id");
    return _requestFormMap(uri).then((value) => Article.fromJson(value));
  }

  ///请求信息流
  Future<StoriesIndex> getStories() {
    var uri = Uri.parse("https://news-at.zhihu.com/api/4/news/latest");
    return _requestFormMap(uri).then((map) => StoriesIndex.fromJson(map));
  }

  ///获取应用列表
  Future<List<AppSummary>> getApps() {
    var uri = Uri.parse("http://api.fir.im/apps?api_token=${Config.API_TOKEN}");
    return _requestFormMap(uri).then((value) {
      return AppsAll.fromJson(value).items;
    }, onError: ErrorHandlerFactory.printError);
  }

  ///获取应用详情
  Future<AppDetailInfo> getAppInfo(String id) {
    var uri =
        Uri.parse("http://api.fir.im/apps/$id?api_token=${Config.API_TOKEN}");
    return _requestFormMap(uri).then((value) {
      return AppDetailInfo.fromJson(value);
    }, onError: ErrorHandlerFactory.printError);
  }

  ///获取应用发布历史-30个
  Future<List<ReleaseDetail>> getAppReleases(String id) {
    var uri = Uri.parse(
        "http://api.fir.im/apps/$id/releases?api_token=${Config.API_TOKEN}");
    return _requestFormMap(uri).then((value) {
      var pageBean = PageResponse.fromJson(value);
      assert(pageBean.datas is List<dynamic>);
      return pageBean.datas.map((item) => ReleaseDetail.fromJson(item)).toList();
    }, onError: ErrorHandlerFactory.printError);
  }

  Future<String> getString(Uri url) {
    return _requestString(url);
  }

  Future<List<dynamic>> _requestFormList(Uri url) {
    return _requestString(url).then((json) {
      if (json != null) {
        return Future.value(jsonDecode(json));
      } else {
        return null;
      }
    });
  }

  Future<Map> _requestFormMap(Uri url) {
    return _requestString(url).then((json) {
      _printWrapped(json);
      if (json != null) {
        return jsonDecode(json);
      } else {
        return null;
      }
    });
  }

  Future<String> _requestString(Uri url) {
    return _httpClient
        .getUrl(url)
        .then((request) => request.close())
        .then((response) {
      if (response.statusCode == HttpStatus.ok) {
        return response.transform(Utf8Decoder());
      } else {
        throw HttpException("网络异常", uri: url);
      }
    }).then((data) => data.join());
  }

  void _printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }
}

class _ApiImp extends Api {}
