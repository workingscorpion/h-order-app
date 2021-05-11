import 'package:h_order/http/client.dart';
import 'package:h_order/http/types/layout/layoutModel.dart';
import 'package:h_order/utils/lazy.dart';
import 'package:mobx/mobx.dart';

part 'layoutStore.g.dart';

class LayoutStore extends LayoutStoreBase with _$LayoutStore {
  static final Lazy<LayoutStore> _lazy =
      Lazy<LayoutStore>(() => new LayoutStore());

  static LayoutStore get instance => _lazy.value;
}

abstract class LayoutStoreBase with Store {
  @observable
  LayoutModel layout;

  @observable
  bool loading = false;

  @action
  load() async {
    if (loading) {
      return;
    }

    try {
      loading = true;

      layout = await Client.create().layout();
    } finally {
      loading = false;
    }
  }
}
