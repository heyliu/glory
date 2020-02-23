import 'package:flutter/material.dart';
import 'package:glory/rout.dart';
import 'package:glory/style/style.dart';
import 'package:glory/utils/error.dart';
import 'package:glory/zhihu/api/api.dart';
import 'package:glory/zhihu/model/fir_response.dart';
import 'package:glory/utils/utils.dart';
import 'package:intl/intl.dart';

class Config {
  static const API_TOKEN = "6c7a8b1c2a3e9a50943b0798c77cbdc7";
}

//#region ====所有App页面====
class AppAllPage extends StatefulWidget {
  static final router = RoutDef.simple("/apps/all", () => AppAllPage());

  Widget build(BuildContext context, {Widget body}) {
    return SimpleScaffold(
      title: Text("fir包管理器"),
      body: body.background(color: Colors.black),
    );
  }

  @override
  State<StatefulWidget> createState() => _AppAllState();
}

class _AppAllState extends State<AppAllPage> {
  bool loading = true;

  List<AppSummary> appList;

  void loadingData() {
    Api.get().getApps().then((data) {
      setState(() {
        loading = false;
        appList = data;
      });
    }, onError: (e, trace) {
      ErrorHandlerFactory.printError(e, trace);
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    loadingData();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context,
        body: LoadingWrapperWidget(
            loading: loading,
            childBuilder: () {
              if (getSize(appList) <= 0) {
                return errorTip;
              } else {
                return GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: appList.length,
                  itemBuilder: buildItem,
                );
              }
            }).background(color: Color(0xfff0f1f2)));
  }

  final Widget errorTip =
      Center(child: Text("暂无相关数据", style: GTextStyle.S15_BLACK));

  Widget buildItem(BuildContext context, int pos) {
    assert(appList != null && appList.isNotEmpty);
    assert(pos < appList.length);
    final item = appList[pos];
    return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      SizedBox(
        height: 20,
      ),
      SizedBox(
        width: 40,
        height: 40,
        child: Image.network(
          item.iconUrl,
        ),
      ),
      Text(
        "应用：${item.name}",
        style: GTextStyle.S15_BLACK,
      ).padding(padding: EdgeInsets.only(top: 10)),
      Text("版本号：${item.masterRelease.version}(${item.masterRelease.build})",
              style: GTextStyle.S14_BLACK)
          .padding(padding: EdgeInsets.only(top: 5)),
      Text(
        "上传时间：${item.masterRelease.createdAt}",
        style: GTextStyle.S14_BLACK,
      ).padding(padding: EdgeInsets.only(top: 5))
    ]).onTap(onTap: () {
      GRouter.gotoRouter(context, AppInfoPage.router.getRouter(item.id));
    }).background(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)));
  }
}
//endregion

//#region ====详情页面====
class AppInfoPage extends StatefulWidget {
  static final router = RoutDef("/apps/:id/detail", (_, param) {
    return AppInfoPage(param["id"][0]);
  }, getPath: (id) => "/apps/$id/detail");

  final String appId;

  AppInfoPage(this.appId);

  Widget build(BuildContext context, {Widget body}) {
    return SimpleScaffold(
      title: Text("fir包管理器"),
      body: body.background(color: Color(0xfff0f1f2)),
    );
  }

  @override
  State<StatefulWidget> createState() => AppInfoState();
}

class AppInfoState extends State<AppInfoPage> {
  List<ReleaseDetail> _releases;

  AppDetailInfo _detailInfo;

  bool _loadAppDetail;
  bool _loadReleases;

  @override
  void initState() {
    super.initState();
    _loadAppDetail = _loadReleases = true;
    Api.get().getAppInfo(widget.appId).then((value) {
      setState(() {
        _loadAppDetail = false;
        _detailInfo = value;
      });
    });

    Api.get().getAppReleases(widget.appId).then((value) {
      setState(() {
        _loadReleases = false;
        _releases = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
//    int count = _detailInfo == null ? 0 : 1;
    int count = 1 + getSize(_releases);

    var body = ListView.separated(
        itemBuilder: (ctx, pos) {
          if (pos == 0) {
            return _buildHead(_detailInfo).background(color: Colors.white);
          } else {
            return _buildItem(_releases[pos - 1])
                .background(color: Colors.white);
          }
        },
        separatorBuilder: (ctx, pos) {
          return SizedBox(height: 10);
        },
        itemCount: count);
    return widget.build(context, body: body);
  }

  Widget _buildHead(AppDetailInfo appInfo) {
    return LoadingWrapperWidget(
        loading: _loadAppDetail,
        childBuilder: () {
          return Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.network(appInfo.iconUrl, width: 40, height: 40),
              SizedBox(width: 10),
              Expanded(
                child: Table(
                  columnWidths: {0: FixedColumnWidth(50)},
                  children: [
                    TableRow(children: [
                      Text(
                        "链接:",
                        style: GTextStyle.S15_BLACK.copyWith(height: 1),
                      ).padding(padding: EdgeInsets.only(top: 10)),
                      Text("https://fir.im/${appInfo.short}",
                              style: GTextStyle.S15_BLACK.copyWith(height: 1))
                          .padding(padding: EdgeInsets.only(top: 10))
                    ]),
                    TableRow(children: [
                      Text("包名:",
                              style: GTextStyle.S15_BLACK.copyWith(height: 1))
                          .padding(padding: EdgeInsets.only(top: 10)),
                      Text(appInfo.bundleId,
                              style: GTextStyle.S15_BLACK.copyWith(height: 1))
                          .padding(padding: EdgeInsets.only(top: 10))
                    ])
                  ],
                ),
              )
            ],
          ).padding(padding: EdgeInsets.only(top: 10, bottom: 10));
        });
  }

  Widget _buildItem(ReleaseDetail release) {
    RegExp exp = new RegExp(r"[\w\d]{8}\s?-\s?(\((HEAD.*\d\)|tag.*\)\))\s?)?");
    var formatChangeLog = (String changeLog) {
      return changeLog.replaceAll(exp, "");
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          release.version + " (Build)${release.build}",
          style: GTextStyle.S15_BOLD,
        ),
        Text(
          DateFormat("yyyy-MM-dd HH:mm:ss").format(
              DateTime.fromMillisecondsSinceEpoch(release.createdAt * 1000)),
          style: GTextStyle.S15_BLACK,
        ),
        Text(formatChangeLog(release.changelog),style: GTextStyle.S14_BLACK)
      ],
    ).padding(padding: EdgeInsets.all(14));
  }
}

//endregion ==========

typedef WidgetBuilder = Widget Function();

/// loading封装
class LoadingWrapperWidget extends StatelessWidget {
  final bool loading;
  final WidgetBuilder childBuilder;

  LoadingWrapperWidget({this.loading, this.childBuilder});

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: RefreshProgressIndicator());
    } else {
      return childBuilder();
    }
  }
}

class SimpleScaffold extends StatelessWidget {
  final Widget body;
  final Widget title;
  final bool centerTitle;

  const SimpleScaffold({this.title, this.body, this.centerTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title,
        centerTitle: centerTitle,
      ),
      body: body,
    );
  }
}
