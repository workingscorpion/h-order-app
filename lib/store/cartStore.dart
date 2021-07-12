import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/service/serviceModel.dart';
import 'package:h_order/store/paymentStore.dart';
import 'package:h_order/utils/lazy.dart';
import 'package:mobx/mobx.dart';

part 'cartStore.g.dart';

class CartStore extends CartStoreBase with _$CartStore {
  static final Lazy<CartStore> _lazy = Lazy<CartStore>(() => new CartStore());

  static CartStore get instance => _lazy.value;
}

abstract class CartStoreBase with Store {
  @observable
  ServiceModel service;

  @observable
  bool loading = false;

  @action
  load(String serviceObjectId) async {
    if (loading) {
      return;
    }

    try {
      loading = true;

      await PaymentStore.instance.loadCards();
      service = await Client.create().service(serviceObjectId);
    } finally {
      loading = false;
    }
  }
}
