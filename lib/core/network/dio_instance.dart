import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Custom Interceptor
import 'package:cream_sns/core/network/pretty_logger.dart';

// Provider
import 'package:path_provider/path_provider.dart';

// Cookie
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

final dioProvider = Provider((ref) {
  final dioInstance = DioInstance();
  dioInstance.initInterceptor();
  return dioInstance;
});

class DioInstance {
  DioInstance();

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://10.0.2.2:8080",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {"Content-Type": Headers.formUrlEncodedContentType},
      extra: {'withCredentials': true},
    ),
  );

  Future<void> initCookie() async {
    final dir = await getApplicationDocumentsDirectory();
    final storage = FileStorage("${dir.path}/.cookies");
    final cookieJar = PersistCookieJar(storage: storage);
    dio.interceptors.add(CookieManager(cookieJar));
  }

  void initInterceptor() {
    dio.interceptors.add(PrettyLogger());
  }

  Future<Response<T>> get<T>(String path) async {
    return await dio.get(path);
  }

  Future<Response<T>> post<T>({required String path, data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response<T>> patch<T>({required String path, data}) async {
    return await dio.patch(path, data: data);
  }

  Future<Response<T>> delete<T, F extends Object>(
    String path, {
    F? data,
  }) async {
    return await dio.delete(path, data: data);
  }
}
