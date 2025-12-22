import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Custom Interceptor
import 'package:cream_sns/core/network/pretty_logger.dart';

// Provider
import 'package:path_provider/path_provider.dart';

// Cookie
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

final dioProvider = Provider((ref) => DioInstance());

class DioInstance {
  static final DioInstance _instance = DioInstance._internal();
  late final Dio dio;

  final _options = BaseOptions(
    baseUrl: "https://port-0-cream-sns-server-mizowz3jcbb29421.sel3.cloudtype.app",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {"Content-Type": Headers.formUrlEncodedContentType},
    extra: {'withCredentials': true},
  );

  factory DioInstance() {
    return _instance;
  }

  DioInstance._internal() {
    dio = Dio(_options);
    _initInterceptor();
  }

  Future<void> initCookie() async {
    final dir = await getApplicationDocumentsDirectory();
    final storage = FileStorage("${dir.path}/.cookies");
    final cookieJar = PersistCookieJar(storage: storage);
    dio.interceptors.add(CookieManager(cookieJar));
  }

  void _initInterceptor() {
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

  Future<Response<T>> delete<T>(String path) async {
    return await dio.delete(path);
  }
}