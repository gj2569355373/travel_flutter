import 'package:json_annotation/json_annotation.dart';
import 'package:sp_util/sp_util.dart';

import 'api.dart';
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
