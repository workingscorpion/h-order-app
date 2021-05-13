// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'billStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BillStore on BillStoreBase, Store {
  final _$billsAtom = Atom(name: 'BillStoreBase.bills');

  @override
  List<BillModel> get bills {
    _$billsAtom.reportRead();
    return super.bills;
  }

  @override
  set bills(List<BillModel> value) {
    _$billsAtom.reportWrite(value, super.bills, () {
      super.bills = value;
    });
  }

  final _$totalAtom = Atom(name: 'BillStoreBase.total');

  @override
  int get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(int value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  final _$loadingAtom = Atom(name: 'BillStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$loadAsyncAction = AsyncAction('BillStoreBase.load');

  @override
  Future load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    return '''
bills: ${bills},
total: ${total},
loading: ${loading}
    ''';
  }
}
