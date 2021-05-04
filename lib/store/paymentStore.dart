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
  List<PaymentMethodModel> cards;

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

  // @action
  // updateCategoryPosition({
  //   String categoryObjectId,
  //   int position,
  // }) async {
  //   await WorkApi.updateCategoryPosition(
  //     categoryObjectId: categoryObjectId,
  //     position: position,
  //   );
  // }

  // @action
  // updateCardPosition({
  //   String categoryObjectId,
  //   String cardObjectId,
  //   int position,
  // }) async {
  //   await WorkApi.updateCardPosition(
  //     categoryObjectId: categoryObjectId,
  //     cardObjectId: cardObjectId,
  //     position: position,
  //   );
  // }

  // @action
  // createCard({
  //   String categoryObjectId,
  //   String content,
  // }) async {
  //   await WorkApi.createCard(
  //     categoryObjectId: categoryObjectId,
  //     content: content,
  //   );

  //   await loadWork();
  // }

  // @action
  // updateCategoryTitle({
  //   String categoryObjectId,
  //   String title,
  // }) async {
  //   await WorkApi.updateCategoryTitle(
  //     categoryObjectId: categoryObjectId,
  //     title: title,
  //   );
  // }
}
