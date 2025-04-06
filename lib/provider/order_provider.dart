



import 'package:agriplant/models/order.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {

  FilterStatus orderFilterStatus = FilterStatus.processing;

  final filters = [
    FilterStatus.processing,
    FilterStatus.shipped,
    FilterStatus.outofDelivery,
    FilterStatus.delivered,
  ];

  void changeStatus(FilterStatus status){
    orderFilterStatus = status;
    notifyListeners();
  }

}