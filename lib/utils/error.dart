///异常处理器
typedef ErrorHandler = bool Function(Object, StackTrace);

class ErrorHandlerFactory {
  static ErrorHandler printError = (e, trace) {
    if (e != null) {
      print("异常发生$e");
    }
    if (trace != null) {
      print(trace);
    }
    return false;
  };
//
//  static ErrorHandler defaultHttpHandler = (e, trace) {
//    printError(e, trace);
//    if (e is JsonParseException) {
//      Fluttertoast.showToast(msg: "服务器返回的数据无法解析");
//      return true;
//    } else if (e is ResponseCodeException) {
//      String errorTip;
//      switch (e.statueCode) {
//        case 401:
//          errorTip = "登录已过期，请重新登录！";
//          break;
//        case 404:
//          errorTip = "接口不存在！";
//          break;
//        case 500:
//          errorTip = "服务器异常，请稍后再次尝试！";
//          break;
//      }
//      Fluttertoast.showToast(msg: errorTip ?? "请求异常");
//      return true;
//    } else if (e is HttpException) {
//      Fluttertoast.showToast(msg: "服务器异常");
//      return true;
//    } else {
////ExceptionUtils.print(e, trace);
//      return false;
//    }
//  }
}






