import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/pagination/pageModel.dart';
import 'package:h_order/models/billModel.dart';
import 'package:h_order/utils/lazy.dart';
import 'package:mobx/mobx.dart';

part 'billStore.g.dart';

class BillStore extends BillStoreBase with _$BillStore {
  static final Lazy<BillStore> _lazy = Lazy<BillStore>(() => new BillStore());

  static BillStore get instance => _lazy.value;
}

abstract class BillStoreBase with Store {
  @observable
  List<BillModel> bills;

  @observable
  int total;

  @observable
  bool loading = false;

  @action
  load() async {
    if (loading) {
      return;
    }

    try {
      loading = true;

      PageModel result = await Client.create().bills();
      bills = result.list.map((e) => BillModel.fromJson(e)).toList();
      total = result.total;
    } finally {
      loading = false;
    }
  }
}
