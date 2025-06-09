// ignore_for_file: file_names

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:evolesoft_app/models/model.dart';
// import 'package:evolesoft_app/models/getEmployeesDataResponseModel.dart';

import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../utils/appNetwork.dart';
part 'apiClient.g.dart';

@RestApi(baseUrl: AppNetwork.baseUrl)
abstract class ApiClient {
  // Factory constructor for creating an instance of ApiClient
  factory ApiClient({String? baseUrl}) {
    // Create a Dio instance with specified options
    Dio dio = Dio();
    dio.options = BaseOptions(
      receiveTimeout: const Duration(seconds: 10),
      connectTimeout: const Duration(seconds: 10),
      baseUrl: baseUrl ?? AppNetwork.baseUrl,
    );

    // Set content-type header
    dio.options.headers['content-type'] = "application/json";
    dio.options.headers['projectId'] = "66ae463bd09e8cc8a8afd346";
    dio.options.headers['environmentId'] = "66ae463bd09e8cc8a8afd347";
    // Add logging interceptors for debugging

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        logPrint: (b) {
          print(b);
        },
      ),
    );

    // Add interceptors for handling requests, responses, and errors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          return handler.next(e);
        },
      ),
    );
    // Configure HttpClientAdapter to handle SSL
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
          client.badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
          return client;
        };

    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET('charging-stations')
  Future<List<ChargingStationListModel>> getChargingStationList();
  // New method to get status by station ID

  @GET('charging-stations/{stationId}')
  Future<ChargingStationListModel> getChargingStationStatus(
    @Path('stationId') String stationId,
  );
}
