import 'dart:convert';
import 'dart:io';


abstract class Api {
  static _ApiImp instance;

  static get() {
    if (instance == null) {
      instance = _ApiImp();
    }
    return instance;
  }

  var httpClient = new HttpClient();

//  getArticle(int id) {
//    httpClient.getUrl("")
//        .then((request) {
//      return request.close();
//    }).then((response) {
//      response.transform(Utf8Decoder());
//    })
//  }


  _requestJson(Uri url) {
    return httpClient.getUrl(url)
        .then((request) {
      return request.close();
    }).then((response) {
      return response.transform(Utf8Decoder()).join();
    });
  }


}


class _ApiImp extends Api {
}


class _Engin {

  var httpClient = new HttpClient();

  Future<String> requestString(Uri uri) async {
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      return await response
          .transform(Utf8Decoder())
          .join();
    } else {}
  }


}
