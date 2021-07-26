// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paymentStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PaymentStore on PaymentStoreBase, Store {
  final _$changeModeAtom = Atom(name: 'PaymentStoreBase.changeMode');

  @override
  bool get changeMode {
    _$changeModeAtom.reportRead();
    return super.changeMode;
  }

  @override
  set changeMode(bool value) {
    _$changeModeAtom.reportWrite(value, super.changeMode, () {
      super.changeMode = value;
    });
  }

  final _$loadingAtom = Atom(name: 'PaymentStoreBase.loading');

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

  final _$loadCardsAsyncAction = AsyncAction('PaymentStoreBase.loadCards');

  @override
  Future loadCards() {
    return _$loadCardsAsyncAction.run(() => super.loadCards());
  }

  final _$updatePrimaryAsyncAction =
      AsyncAction('PaymentStoreBase.updatePrimary');

  @override
  Future updatePrimary(String index) {
    return _$updatePrimaryAsyncAction.run(() => super.updatePrimary(index));
  }

  @override
  String toString() {
    return '''
changeMode: ${changeMode},
loading: ${loading}
    ''';
  }
}
