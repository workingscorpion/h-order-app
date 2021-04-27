import 'package:dio/dio.dart';
import 'package:h_order/http/types/login/requestLoginModel.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: "http://192.168.0.104:5000/api")
abstract class Client {
  factory Client.create() => _Client(Dio());

  @POST("/v1/auth/login/device")
  Future login(
    @Body() RequestLoginModel location,
  );

  @POST("/v1/auth/logout")
  Future logout();
}
