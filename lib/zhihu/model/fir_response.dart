import 'package:json_annotation/json_annotation.dart';

part 'fir_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PageResponse {
  PageResponse();

  int totalCount;
  int totalPages;
  int currentPage;
  List<dynamic> datas;

  factory PageResponse.fromJson(Map<String, dynamic> json) =>
      _$PageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageResponseToJson(this);

}

///所有App
@JsonSerializable(fieldRename: FieldRename.snake)
class AppsAll {
  AppsAll();

  int appsCount;
  int pageSize;
  List<AppSummary> items;

  factory AppsAll.fromJson(Map<String, dynamic> json) =>
      _$AppsAllFromJson(json);

  Map<String, dynamic> toJson() => _$AppsAllToJson(this);
}

///单个App简介信息
@JsonSerializable(fieldRename: FieldRename.snake)
class AppSummary {
  AppSummary();

  String id; //"5540802dadd5b62426000cbc",
  String userId; //"5598da0b692d686ff00008d0",
  String type; // "ios",
  String name; // "iOS",
  String short; // "iOSoid",
  String bundleId; //": "im.fir.BugHDClient",
  int genreId; //": 14,
  bool isOpened; //": true,
  String webTemplate; //": "default",
  bool hasCombo; //": false,
  int createdAt; //": 1430290477,
  String iconUrl;
  Release masterRelease;

  factory AppSummary.fromJson(Map<String, dynamic> json) =>
      _$AppSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$AppSummaryToJson(this);
}

///一个发布信息
@JsonSerializable(fieldRename: FieldRename.snake)
class Release {
  Release();

  //这是summary
  String version; //": "1.0",
  String build; //: "2",
  String releaseType; //": "adhoc",
  String distributionName; //": "",
  String supportedPlatform; //": null,
  int createdAt; //": 1443151607

  factory Release.fromJson(Map<String, dynamic> json) =>
      _$ReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ReleaseDetail extends Release {
  ReleaseDetail();

  //@overide
  //String version; //=  "5.5.0";
  //String build; //=  "550022";
  //String releaseType;// = null;
  //String distributionName; //  null;
  //String supportedPlatform; //=  null;

  String id; //=  "5e4fb6b8f945486943ec581c";
  String isSeMqc; //=  null;
  String mqcExecutionId; //=  null;
  String mqcStatus; //=  null;
  String mqcUrl; //=  null;
  String mqcErrorLog; //=  null;
  String changelog; //= fix:点击分享到朋友圈却调起了联系人列表..";
  bool isHistory; //=  false;
  String releaseTag; //=  "develop";
  String minimumOsVersion; //=  null;
  String uiRequiredDeviceCapabilities; //=  null;
  String uiDeviceFamily; // = null;
  bool isOnlined; //=  false;
  bool isExpired; //=  false;
  int createdAt; //=  1582282424;
  Binary binary;

  factory ReleaseDetail.fromJson(Map<String, dynamic> json) =>
      _$ReleaseDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseDetailToJson(this);
}

@JsonSerializable()
class Binary {
  Binary();

  int fsize;

  factory Binary.fromJson(Map<String, dynamic> json) => _$BinaryFromJson(json);

  Map<String, dynamic> toJson() => _$BinaryToJson(this);
}

///app详细信息
@JsonSerializable(fieldRename: FieldRename.snake)
class AppDetailInfo {
  AppDetailInfo();

  String id; //="55559e625370693c78080000",
  String type; // ="android",
  String name; // ="城桦怀_android_admin",
  String desc; // ="",
  String short; // ="wtam",
  bool isOpened; // =true,
  String bundleId; // ="im.fir.xxx",
  bool isShowPlaza; // =true,
  String passwd; // =null,
  int maxReleaseCount; // =10,
  bool isStoreAutoSync; // =false,
  bool storeLinkVisible; // =false,
  int genreId; // =0,
  int createdAt; // =1431674466,
  bool hasCombo; // =false,
  String iconUrl; // =null,
  bool isOwner; // =true

  factory AppDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$AppDetailInfoFromJson(json);

  Map<String, dynamic> toJson() => _$AppDetailInfoToJson(this);
}
