import 'package:agriplant/data/products.dart';
import 'package:agriplant/models/order.dart';

List<OrderModel> orders = [
  OrderModel(
    id: "202304a5",
    products: products.reversed.take(3).toList(),
    date: DateTime.utc(2023),
  ),
  OrderModel(
    id: "202204jm",
    products: products.take(1).toList(),
    date: DateTime.utc(2022),
  ),
  OrderModel(
    id: "201904vc",
    products: products.reversed.skip(3).toList(),
    date: DateTime.utc(2019),
  ),
];
