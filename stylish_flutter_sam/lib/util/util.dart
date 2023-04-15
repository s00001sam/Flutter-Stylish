import 'package:flutter/cupertino.dart';
import 'package:stylish_flutter_sam/data/ProductsDatum.dart';

bool isPhoneDevice(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  return deviceWidth <= 600;
}

extension Iterables<E> on Iterable<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}
