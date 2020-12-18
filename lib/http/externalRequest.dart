import 'package:json_annotation/json_annotation.dart';
import 'package:sp_util/sp_util.dart';
import 'package:travel_flutter/models/panelBin.dart';
import 'package:travel_flutter/models/typeItem.dart';

import 'api.dart';
import 'http_model.dart';
import 'requestAll.dart';

/*
 * create by gj
 * Created in 2020/12/9 3:05 下午
 * description: 外部业务可直接请求的API封装
 * part 'externalRequest.g.dart';
 * 生成fromJson 命令flutter packages pub run build_runner build
 * */
part 'externalRequest.g.dart';

@JsonSerializable()
class TokenModel {
  @JsonKey(name: 'access_token')
  String accessToken;
  @JsonKey(name: 'token_type')
  String tokenType;
  @JsonKey(name: 'refresh_token')
  String refreshToken;
  @JsonKey(name: 'expires_in')
  int expiresIn;
  String scope;
  @JsonKey(ignore: true)
  int nowTime;

  TokenModel(this.accessToken, this.tokenType, this.refreshToken,
      this.expiresIn, this.scope,
      {this.nowTime});

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

  static String getClassName() => "TokenModel"; //用于存储token对象

}

class ExternalRequest {
  static TokenModel _tokenModel;
  //登录API
  Future<bool> login(map) async {
    Map<String, dynamic> baseResp = await RequestAll()
        .requestTravelMap(Method.post, TravelApi.Login, data: map);
    if (baseResp["error"] == null) {
      return setToken(new TokenModel.fromJson(baseResp)
        ..nowTime = DateTime.now().millisecondsSinceEpoch); //存储Token
    } else
      return new Future.error(baseResp["error_description"]);
  }

  Future<List<BannerModel>> getBanner() async {
    BaseRespTravel<List> baseResp = await RequestAll()
        .requestTravel<List>(Method.get, WanAndroid.banner);
    List<BannerModel> bannerList;
//    if (baseResp.code != 0) {
//      return new Future.error(baseResp.msg);
//    }
    if (baseResp.data != null && baseResp.data.length>0) {
      bannerList = baseResp.data.map((value) {
//        return new Future.error("错误");
        return BannerModel.fromJson(value);
      }).toList();
    }
    return bannerList;
  }

  Future<List<TypeItem>> getCustomDomain() async {
    BaseRespTravel<List> baseResp = await RequestAll()
        .requestTravel<List>(Method.get, WanAndroid.banner);
    List<TypeItem> ls;
//    if (baseResp.code != 0) {
//      return new Future.error(baseResp.msg);
//    }
    if (baseResp.data != null && baseResp.data.length>0) {
      var json=[{'title':'百度','image':'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1559110934104&di=51ac29da896d9d6d942eac302e71258d&imgtype=0&src=http%3A%2F%2Fs7.sinaimg.cn%2Fbmiddle%2F494028914443aa70b4bf6','type':2,'urlPage':'http://www.baidu.com'},{'title':'OnePage','image':'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=354865630,1374999026&fm=15&gp=0.jpg','type':1,'urlPage':'onePage'},{'title':'twoPage','image':'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3196416985,685332592&fm=15&gp=0.jpg','type':1,'urlPage':'twoPage'},{'title':'threePage','image':'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1124029688,2135689418&fm=15&gp=0.jpg','type':1,'urlPage':'threePage'},{'title':'fourPage','image':'http://d.lanrentuku.com/down/png/1712/22xiaodongwu/22xiaodongwu_12.png','type':1,'urlPage':'fourPage'},{'title':'查看供应商','image':'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=175452447,2068155536&fm=15&gp=0.jpg','type':2,'urlPage':'http://www.baidu.com'},{'title':'threePage','image':'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1124029688,2135689418&fm=15&gp=0.jpg','type':1,'urlPage':'threePage'},{'title':'fourPage','image':'http://d.lanrentuku.com/down/png/1712/22xiaodongwu/22xiaodongwu_12.png','type':1,'urlPage':'fourPage'},{'title':'查看供应商','image':'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=175452447,2068155536&fm=15&gp=0.jpg','type':2,'urlPage':'http://www.baidu.com'}];
      ls = json.map((value) {
        return TypeItem.fromJson(value);
      }).toList();
    }
    return ls;
  }

  Future<List<PanelBin>> getHomePanel() async {
    BaseRespTravel<List> baseResp = await RequestAll()
        .requestTravel<List>(Method.get, WanAndroid.banner);
    List<PanelBin> ls;
    if (baseResp.data != null && baseResp.data.length>0) {
      var json=[{'title':'待确认','count':'35','styleType':1,'urlPage':'fourPage'},{'title':'待发货','count':'35','styleType':1,'urlPage':'fourPage'},{'title':'fourPage','count':'35','styleType':1,'urlPage':'fourPage'},{'title':'fourPage','count':'35','styleType':1,'urlPage':'fourPage'},{'title':'fourPage','count':'35','styleType':1,'urlPage':'fourPage'},{'title':'fourPage','count':'35','styleType':1,'urlPage':'fourPage'},{'title':'fourPage','count':'35','styleType':1,'urlPage':'fourPage'},{'title':'fourPage','count':'35','styleType':1,'urlPage':'fourPage'}];
      ls = json.map((value) {
        return PanelBin.fromJson(value);
      }).toList();
    }
    return ls;
  }

  static Future<bool> setToken(TokenModel tokenModels) {
    _tokenModel = tokenModels;
    return SpUtil.putObject(TokenModel.getClassName(), _tokenModel);
  }

  static TokenModel getToken() {
    _tokenModel ??= SpUtil.getObj<TokenModel>(
        TokenModel.getClassName(), (map) => TokenModel.fromJson(map),
        defValue: null);
    if (_tokenModel == null) return null;
    return verificationToken() ? _tokenModel : null;
  }

  //验证Token是否有效
  static bool verificationToken({TokenModel t}) {
    if (t != null)
      return t.nowTime + t.expiresIn * 1000 >
          DateTime.now().millisecondsSinceEpoch - 60 * 1000;
    if (_tokenModel != null)
      return _tokenModel.nowTime + _tokenModel.expiresIn * 1000 >
          DateTime.now().millisecondsSinceEpoch - 60 * 1000;
    return false;
  }
}
