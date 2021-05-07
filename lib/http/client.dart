import 'package:dio/dio.dart';
import 'package:h_order/http/types/layout/layoutModel.dart';
import 'package:h_order/http/types/login/requestLoginModel.dart';
import 'package:h_order/http/types/payment/cardRegisterModel.dart';
import 'package:h_order/models/paymentMethodModel.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:retrofit/retrofit.dart';

part 'client.g.dart';

@RestApi(baseUrl: "http://192.168.0.103:5000/api")
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

  @GET("/v1/device/layout")
  Future<LayoutModel> layout();

  @GET("/v1/device/service")
  Future<List<ServiceModel>> services();

  @GET("/v1/device/service/{objectId}")
  Future<ServiceModel> service(@Path('objectId') String objectId);

  @POST("/v1/device/paymentmethod/register")
  Future<PaymentMethodModel> cardRegister(
    @Body() CardRegisterModel card,
  );

  @GET("/v1/device/paymentmethod")
  Future<List<PaymentMethodModel>> cards();
}
