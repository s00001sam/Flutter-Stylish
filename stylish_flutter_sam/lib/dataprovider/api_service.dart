import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:stylish_flutter_sam/data/ProductsDatum.dart';

class ApiService {
  static const _baseUrl = 'https://api.appworks-school.tw/api/1.0';
  static const _womenPath = '/products/women';
  static const _menPath = '/products/men';
  static const _accessoriesPath = '/products/accessories';
  static const _detailPath = '/products/details';

  final _dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
      responseType: ResponseType.json,
    ),
  );

  ApiService() {
    initDioInterceptors();
  }

  Future<Response<dynamic>> getWomenClothes() => _dio.get(_womenPath);

  Future<Response<dynamic>> getMenClothes() => _dio.get(_menPath);

  Future<Response<dynamic>> getAccessories() => _dio.get(_accessoriesPath);

  Future<Response<dynamic>> getProductContent(int id) => _dio.get(
        _detailPath,
        queryParameters: {'id': id},
      );

  void initDioInterceptors() {
    _dio.interceptors.add(PrettyDioLogger());
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        handler.next(options);
      },
      onResponse: (Response response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        return handler.next(e);
      },
    ));
  }
}
