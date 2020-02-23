import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:glory/zhihu/page/package.dart';
import 'utils/utils.dart';

class GRouter {
  final _router = Router();
  static GRouter instance;

  static void gotoRouter(BuildContext context, String rout,
      {TransitionType transition = TransitionType.fadeIn}) {
    GRouter.get().goto(context, rout);
  }

  factory GRouter.get() {
    if (instance == null) {
      instance = GRouter._();
    }
    return instance;
  }

  GRouter._() {
    init();
  }

  void init() {
    defineRouterByRoutDef(AppAllPage.router);
    defineRouterByRoutDef(AppInfoPage.router);
  }

//  void defineRouter(String path,Handler handler){
//    _router.define(path, handler: handler);
//  }

  void defineRouterByRoutDef(RoutDef routDef) {
    _router.define(routDef.baseRout,
        handler: Handler(handlerFunc: routDef.gotoFunc));
  }

  void generator() {
    _router.generator(null);
  }

  void goto(BuildContext context, String rout,
      {TransitionType transition = TransitionType.fadeIn}) {
    _router.navigateTo(context, rout, transition: transition);
  }
}

class RoutDef {
  final String baseRout;
  final Widget Function(BuildContext, Map<String, List<String>> param) gotoFunc;

  final String Function(Object) getPath;

  String getRouter(Object params) {
    if (getPath == null) {
      return baseRout;
    } else {
      return getPath(params);
    }
  }

  RoutDef(this.baseRout, this.gotoFunc, {this.getPath});

  RoutDef.simple(this.baseRout, Widget Function() builder, {this.getPath})
      : this.gotoFunc = ((BuildContext ctx, param) => builder());
}
