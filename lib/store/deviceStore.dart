import 'dart:async';

import 'package:h_order/http/client.dart';
import 'package:mobx/mobx.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:http/http.dart' hide Client;
import 'package:http/io_client.dart';
import 'package:h_order/utils/lazy.dart';
import 'package:h_order/models/deviceModel.dart';

part 'deviceStore.g.dart';

class DeviceStore extends DeviceStoreBase with _$DeviceStore {
  static final Lazy<DeviceStore> _lazy =
      Lazy<DeviceStore>(() => new DeviceStore());

  static DeviceStore get instance => _lazy.value;
}

abstract class DeviceStoreBase with Store {
  @observable
  DeviceModel device;

  @observable
  bool loading = false;

  @observable
  HubConnection hubConnection;

  @observable
  bool isConnected = false;

  @observable
  Stream<PushNotificationModel> stream =
      Stream<PushNotificationModel>.empty().asBroadcastStream();

  @action
  getDevice() async {
    device = await Client.create().device();
  }

  @action
  connectHub() async {
    if (hubConnection != null) {
      hubConnection.stop();
    }

    hubConnection = HubConnectionBuilder()
        .withUrl(
          Client.signalRUrl,
          HttpConnectionOptions(
            client: SignalRClient(),
            logging: (level, message) {
              print('### $level $message');
            },
          ),
        )
        .withAutomaticReconnect()
        .build();

    hubConnection.on('notified', (json) {
      final map = json.first as Map;
      print(map.toString());
      // if (map['type'] != null) {
      //   final type = map['type'] as int;
      //   final targetObjectId = map['targetObjectId'] as String;

      //   print(type.toString());
      //   print(targetObjectId);
      // }
    });

    await hubConnection.start();
  }
}

class PushNotificationModel {
  final int type;
  final String hotelUrl;
  final String hotelObjectId;
  final String targetObjectId;
  final dynamic data;

  PushNotificationModel({
    this.type,
    this.hotelUrl,
    this.hotelObjectId,
    this.targetObjectId,
    this.data,
  });
}

class SignalRClient extends IOClient {
  @override
  Future<IOStreamedResponse> send(BaseRequest request) async {
    final list = Client.cookieJar.loadForRequest(request.url);
    final cookie = list.map((e) => '${e.name}=${e.value};').join(' ');
    request.headers['Cookie'] = cookie;

    return super.send(request);
  }
}
