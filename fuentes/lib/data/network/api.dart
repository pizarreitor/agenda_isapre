import 'package:dio/dio.dart';

class Api {
  late Dio dio;
  Api(){
    dio = Dio(
      BaseOptions(
        baseUrl: "https://apiweb-test.isaprefundacion.cl/api",
        connectTimeout:  const Duration(seconds: 30000),
        receiveTimeout:  const Duration(seconds: 30000),
      )
    );
  }

  Future get(String endpoint)async {
    try{
      final Response response = await dio.get(endpoint);
      return validateResponse(response);
    }on DioException catch(error){
      throw Exception("Error interno $error");
    }
  }

  Future post(String endpoint,Map body)async {
    try{
      final Response response = await dio.post(endpoint,data: body);

      // print("jsonResponse ${response.data}");
      // print("jsonResponse ${response.statusCode}");
      return validateResponse(response);
    }on DioException catch(error){
      throw Exception("Error interno $error");
    }
  }

  Future put(String endpoint,Map body)async {
    try{
      final Response response = await dio.put(endpoint,data: body);
      return validateResponse(response);
    }on DioException catch(error){
      throw Exception("Error interno $error");
    }
  }

  Future delete(String endpoint)async {
    try{
      final Response response = await dio.delete(endpoint);
      // print("jsonResponse ${response}");
      return validateResponse(response);
    }on DioException catch(error){
      throw Exception("Error interno $error");
    }
  }

  validateResponse(Response response){
    switch(response.statusCode){
      case 200:
      case 201:
        return response.data;
      case 400:
      case 401:
      case 409:
        throw Exception(response.data["error"]).toString();
      case 500:
      default:
        throw Exception("Error en el servidor ${response.statusCode.toString()}");
    }
  }
}