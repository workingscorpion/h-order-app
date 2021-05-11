import 'package:h_order/http/client.dart';
import 'package:h_order/utils/lazy.dart';
import 'package:mobx/mobx.dart';
import 'package:h_order/http/types/service/serviceModel.dart';

part 'serviceStore.g.dart';

class ServiceStore extends ServiceStoreBase with _$ServiceStore {
  static final Lazy<ServiceStore> _lazy =
      Lazy<ServiceStore>(() => new ServiceStore());

  static ServiceStore get instance => _lazy.value;
}

abstract class ServiceStoreBase with Store {
  ObservableList<ServiceModel> services = ObservableList();
  ObservableMap<String, ServiceModel> serviceMap = ObservableMap();

  @observable
  bool loading = false;

  @action
  load() async {
    if (loading) {
      return;
    }

    try {
      loading = true;

      final list = await Client.create().services();

      services
        ..clear()
        ..addAll(list);

      serviceMap
        ..clear()
        ..addEntries(list.map((e) => MapEntry(e.objectId, e)));
    } finally {
      loading = false;
    }
  }

  @action
  loadSingle(String objectId) async {
    if (loading) {
      return;
    }

    try {
      loading = true;

      final item = await Client.create().service(objectId);
      final index = services.indexWhere((a) => a.objectId == item.objectId);

      if (index != -1) {
        services.replaceRange(index, index + 1, [item]);
      } else {
        services.add(item);
      }

      serviceMap[item.objectId] = item;
    } finally {
      loading = false;
    }
  }
}
