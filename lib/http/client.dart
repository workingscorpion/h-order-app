import 'package:dio/dio.dart';
import 'package:h_order/http/types/layout/layoutModel.dart';
import 'package:h_order/http/types/login/requestLoginModel.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: "http://192.168.0.104:5000/api")
abstract class Client {
  factory Client.create() => _Client(
        Dio(
          BaseOptions(
            headers: token != null
                ? {
                    "Authorization": 'Bearer $token',
                  }
                : {},
          ),
        ),
      );

  static String token;

  @POST("/v1/auth/login/device")
  Future login(
    @Body() RequestLoginModel location,
  );

  @POST("/v1/auth/logout")
  Future logout();

  @POST("/v1/device/layout")
  Future<LayoutModel> layout();

  @POST("/v1/device/layout")
  Future<List<ServiceModel>> services();
}
