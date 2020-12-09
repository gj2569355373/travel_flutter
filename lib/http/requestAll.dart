/*
 * create by gj
 * Created in 2020/12/9 11:33 上午
 * description: 
 * */
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:travel_flutter/utils/http/dio_util.dart';
/// <BaseResp<T> 返回 status code msg data.\
class BaseRespTravel<T> {
  bool success;
  int code;
  String msg;
  T data;

  BaseRespTravel(this.success, this.code, this.msg, this.data);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write("\"success\":\"$success\"");
    sb.write(",\"code\":$code");
    sb.write(",\"msg\":\"$msg\"");
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}
/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}
class RequestAll {
  ///旅行社
  String _successKeyT = "success";
  String _msgKeyT = "msg";
  String _dataKeyT = "data";
  String _codeKeyT = "code";

  /// Make http request with options.
  /// [method] The request method.
  /// [path] The url path.
  /// [data] The request data
  /// [options] The request options.
  /// [CancelToken] 通过 cancel token 来取消发起的请求 token.cancel("cancelled");
  /// <BaseResp<T> 返回 status code msg data .
  ///旅行社标准格式API请求
  Future<BaseRespTravel<T>> requestTravel<T>(String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    Response response = await DioUtil.getInstance().getDio().request(path,
        data: data,
        options: DioUtil.getInstance().checkOptions(method, options),
        cancelToken: cancelToken);
    bool _success;
    int _code;
    String _msg;
    T _data;
    if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
      try {
        Map<String, dynamic> _dataMap=(response.data is Map)?response.data:DioUtil.getInstance().decodeData(response);
        _success = (_dataMap[_successKeyT] is bool)
            ? _dataMap[_successKeyT]
            : bool.fromEnvironment(_dataMap[_successKeyT].toString());
        _code = (_dataMap[_codeKeyT] is String)
            ? int.tryParse(_dataMap[_codeKeyT])
            : _dataMap[_codeKeyT];
        _msg = _dataMap[_msgKeyT];
        _data = _dataMap[_dataKeyT];
        return new BaseRespTravel(_success, _code, _msg, _data);
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          error: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      error: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }
  ///返回原始格式数据API请求
  Future<Map<String, dynamic>> requestTravelMap(String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    Response response = await DioUtil.getInstance().getDio().request(path,
        data: data,
        options: DioUtil.getInstance().checkOptions(method, options),
        cancelToken: cancelToken);
    if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
      try {
        Map<String, dynamic> _dataMap=(response.data is Map)?response.data:DioUtil.getInstance().decodeData(response);
        return _dataMap;
      } catch (e) {
        return new Future.error(new DioError(
          response: response,
          error: "data parsing exception...",
          type: DioErrorType.RESPONSE,
        ));
      }
    }
    return new Future.error(new DioError(
      response: response,
      error: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }
}