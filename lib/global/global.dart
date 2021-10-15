import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Global {
  Dio dio;

  Global._privateConstructor() : dio = Dio() {
    dio.options = BaseOptions(
      baseUrl: "https://zxw.td0f7.cn/",
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 5000,
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.json,
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        EasyLoading.show(status: "Loading...");
        return handler.next(options); //continue
      },
      onResponse: (response, handler) {
        EasyLoading.dismiss();
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) {
        print(e.toString());
        EasyLoading.dismiss();
        String msg = "";
        if (e.type == DioErrorType.connectTimeout) {
          msg = "连接超时错误";
        } else {
          msg = "接口错误！";
        }
        EasyLoading.showError(msg);
      },
    ));

  }

  static final Global _instance = Global._privateConstructor();

  static Global get instance => _instance;
}
