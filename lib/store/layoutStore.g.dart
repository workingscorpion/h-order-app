// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layoutStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LayoutStore on LayoutStoreBase, Store {
  final _$layoutAtom = Atom(name: 'LayoutStoreBase.layout');

  @override
  LayoutModel get layout {
    _$layoutAtom.reportRead();
    return super.layout;
  }

  @override
  set layout(LayoutModel value) {
    _$layoutAtom.reportWrite(value, super.layout, () {
      super.layout = value;
    });
  }

  final _$loadingAtom = Atom(name: 'LayoutStoreBase.loading');

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

  final _$loadAsyncAction = AsyncAction('LayoutStoreBase.load');

  @override
  Future load() {
    return _$loadAsyncAction.run(() => super.load());
  }

  @override
  String toString() {
    return '''
layout: ${layout},
loading: ${loading}
    ''';
  }
}
