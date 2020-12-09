/*
 * create by gj
 * Created in 2020/12/9 10:39 上午
 * description: 对于每个dio实例，我们可以添加一个或多个拦截器，通过它们我们可以拦截请求或响应，然后再由then或处理catchError。
 * 可在此进行异地登录的提前处理
 * */
import 'package:dio/dio.dart';

class MyInterceptors extends Interceptor {
  final InterceptorSendCallback _onRequest;
  final InterceptorSuccessCallback _onResponse;
  final InterceptorErrorCallback _onError;

  MyInterceptors({
    InterceptorSendCallback onRequest,
    InterceptorSuccessCallback onResponse,
    InterceptorErrorCallback onError,
  })  : _onRequest = onRequest,
        _onResponse = onResponse,
        _onError = onError;

  @override
  Future onRequest(RequestOptions options) async {
    if (_onRequest != null) {
      return _onRequest(options);
    }
  }

  @override
  Future onResponse(Response response) async {
    if (_onResponse != null) {
      return _onResponse(response);
    }
  }

  @override
  Future onError(DioError err) async {
    if (_onError != null) {
      return _onError(err);
    }
  }
}