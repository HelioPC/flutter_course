// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CounterStore on _CounterStore, Store {
  late final _$counterAtom =
      Atom(name: '_CounterStore.counter', context: context);

  @override
  int get counter {
    _$counterAtom.reportRead();
    return super.counter;
  }

  @override
  set counter(int value) {
    _$counterAtom.reportWrite(value, super.counter, () {
      super.counter = value;
    });
  }

  late final _$_CounterStoreActionController =
      ActionController(name: '_CounterStore', context: context);

  @override
  void add() {
    final _$actionInfo =
        _$_CounterStoreActionController.startAction(name: '_CounterStore.add');
    try {
      return super.add();
    } finally {
      _$_CounterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
counter: ${counter}
    ''';
  }
}
