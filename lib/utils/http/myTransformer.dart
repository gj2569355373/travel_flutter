import 'package:dio/dio.dart';

class MyTransformer extends DefaultTransformer {
  //转码器 允许在将请求/响应数据发送到服务器或从服务器接收之前对请求/响应数据进行更改
  @override
  Future<String> transformRequest(RequestOptions options) async {
    return super.transformRequest(options);
  }

  /// The [Options] doesn't contain the cookie info. we add the cookie
  /// info to [Options.extra], and you can retrieve it in [ResponseInterceptor]
  /// and [Response] with `response.request.extra["cookies"]`.
  @override
  Future transformResponse(
      RequestOptions options, ResponseBody response) async {
    return super.transformResponse(options, response);
  }
}
