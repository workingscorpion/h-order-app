import 'package:h_order/http/client.dart';
import 'package:h_order/models/paymentMethodModel.dart';
import 'package:h_order/utils/lazy.dart';
import 'package:mobx/mobx.dart';

part 'paymentStore.g.dart';

class PaymentStore extends PaymentStoreBase with _$PaymentStore {
  static final Lazy<PaymentStore> _lazy =
      Lazy<PaymentStore>(() => new PaymentStore());

  static PaymentStore get instance => _lazy.value;
}

abstract class PaymentStoreBase with Store {
  @observable
  List<PaymentMethodModel> cards = List();

  @observable
  bool loading = false;

  @action
  loadCards() async {
    if (loading) {
      return;
    }

    try {
      loading = true;
      cards = await Client.create().cards();
    } catch (e) {
      print(e);
      loading = false;
    } finally {
      loading = false;
    }
  }
}
