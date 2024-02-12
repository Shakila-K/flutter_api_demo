import 'package:dio/dio.dart';
import 'package:flutter_dio/internet_services/paths.dart';

class DioClient{

  DioClient._();

  static final instance = DioClient._();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
    ),
  );

  // ///Get Method
  // Future<Map<String, dynamic>> get(
  //     String path, {
  //         Map<String, dynamic>? queryParameters,
  //         Options? options,
  //         CancelToken? cancelToken,
  //         ProgressCallback? onReceiveProgress
  //       }) async{
  //         try{
  //               final Response response = await _dio.get(
  //                path,
  //                queryParameters: queryParameters,
  //                options: options,
  //                cancelToken: cancelToken,
  //                 onReceiveProgress: onReceiveProgress,
  //               );
  //               if(response.statusCode == 200){
  //                 return response.data;
  //               }
  //               throw "something went wrong";
  //           } catch(e){
  //           rethrow;
  //         }
  // }
  ///Get Method
  Future<Map<String, dynamic>> get(
      String path, {
          Map<String, dynamic>? queryParameters,
          Options? options,
          CancelToken? cancelToken,
          ProgressCallback? onReceiveProgress
        }) async{
          try{
                final Response response = await _dio.get(
                 path,
                 queryParameters: queryParameters,
                 options: options,
                 cancelToken: cancelToken,
                  onReceiveProgress: onReceiveProgress,
                );
                print(response.data);
                if (response.statusCode == 200) {
                  final responseData = response.data;
                  if (responseData is Map<String, dynamic>) {
                    print ("ResponseData is Map");
                    print(responseData);
                    return responseData;
                  } else if (responseData is List<dynamic>) {
                    // Convert list to map with index as key
                    final mapData = <String, dynamic>{};
                    for (int i = 0; i < responseData.length; i++) {
                      mapData[i.toString()] = responseData[i];
                    }
                    print("ResponseData is List");
                    return mapData;
                  } else {
                    throw "Unexpected response format";
                  }
                }
                throw "Received status code ${response.statusCode}";
            } catch(e){
            rethrow;
          }
  }

  ///Post Method
  Future<Map<String, dynamic>> post(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress
      }) async{
    try{
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        return response.data;
      }
      throw "something went wrong";
    } catch (e){
      rethrow;
    }
  }

  ///Put Method
  Future<Map<String, dynamic>> put(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress
      }) async{
    try{
      final Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if(response.statusCode == 200){
        return response.data;
      }
      throw "something went wrong";
    } catch (e){
      rethrow;
    }
  }

  ///Delete Method
  Future<dynamic> delete(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress
      }) async{
    try{
      final Response response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,

      );
      if(response.statusCode == 204){
        return response.data;
      }
      throw "something went wrong";
    } catch (e){
      rethrow;
    }
  }

}