// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartStore on CartStoreBase, Store {
  final _$serviceAtom = Atom(name: 'CartStoreBase.service');

  @override
  ServiceModel get service {
    _$serviceAtom.reportRead();
    return super.service;
  }

  @override
  set service(ServiceModel value) {
    _$serviceAtom.reportWrite(value, super.service, () {
      super.service = value;
    });
  }

  final _$loadingAtom = Atom(name: 'CartStoreBase.loading');

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

  final _$loadAsyncAction = AsyncAction('CartStoreBase.load');

  @override
  Future load(String serviceObjectId) {
    return _$loadAsyncAction.run(() => super.load(serviceObjectId));
  }

  @override
  String toString() {
    return '''
service: ${service},
loading: ${loading}
    ''';
  }
}
