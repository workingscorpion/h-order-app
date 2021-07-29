import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:h_order/http/types/layout/layoutModel.dart';
import 'package:h_order/http/types/login/requestLoginModel.dart';
import 'package:h_order/http/types/pagination/pageModel.dart';
import 'package:h_order/http/types/payment/cardRegisterModel.dart';
import 'package:h_order/http/types/payment/paymentPinModel.dart';
import 'package:h_order/http/types/service/actionModel.dart';
import 'package:h_order/models/historyModel.dart';
import 'package:h_order/models/paymentMethodModel.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/http/types/service/orderModel.dart';
import 'package:retrofit/retrofit.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:h_order/models/deviceModel.dart';
import 'package:h_order/http/types/login/requestTermsModel.dart';

part 'client.g.dart';

const protocol = kDebugMode ? 'http' : 'http';
const host = kDebugMode ? '192.168.0.11:5000' : 'jinjoosoft.io:49233';

@RestApi()
abstract class Client {
  factory Client.create() => _Client(
        Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: token != null
                ? {
                    "Authorization": 'Bearer $token',
                  }
                : {},
          ),
        ),
      );

  static CookieJar cookieJar = CookieJar();

  static get baseUrl {
    return "$protocol://$host/api";
  }

  static get signalRUrl {
    return "$protocol://$host/signal";
  }

  static String token;

  @POST("/v1/auth/login/device")
  Future login(
    @Body() RequestLoginModel location,
  );

  @POST("/v1/auth/logout")
  Future logout();

  @GET("/v1/device/device")
  Future<DeviceModel> device();

  @GET("/v1/device/layout")
  Future<LayoutModel> layout();

  @GET("/v1/device/service")
  Future<List<ServiceModel>> services();

  @GET("/v1/device/notice")
  Future<PageModel> notices();

  @GET("/v1/device/history")
  Future<PageModel> histories();

  @GET("/v1/device/bill")
  Future<PageModel> bills();

  @GET("/v1/device/service/{objectId}")
  Future<ServiceModel> service(@Path('objectId') String objectId);

  @POST("/v1/device/paymentMethod/register")
  Future<PaymentMethodModel> cardRegister(
    @Body() CardRegisterModel card,
  );

  @POST("/v1/device/history")
  Future<HistoryModel> order(
    @Body() OrderModel order,
  );

  @GET("/v1/device/paymentMethod")
  Future<List<PaymentMethodModel>> cards();

  @DELETE("/v1/device/paymentMethod/{index}")
  Future deleteCard(
    @Path("index") String index,
  );

  @POST("/v1/device/service/{objectId}/{type}")
  Future serviceAction(
    @Path('objectId') String objectId,
    @Path('type') String type,
    @Body() ActionModel data,
  );

  @PUT("/v1/device/device")
  Future termsUpdate(
    @Body() RequestTermsModel device,
  );

  @PUT("/v1/device/device/register")
  Future pinRegister(
    @Body() PaymentPinModel pinModel,
  );

  @POST("/v1/device/device/pin")
  Future pinCheck(
    @Body() PaymentPinModel pinModel,
  );

  @GET("/v1/device/device/pin")
  Future<PaymentPinModel> pinExist();
}
