import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:machine_test/helper/db_helper.dart';

import '../models/item.dart';

class ItemProvider with ChangeNotifier {
  List<Item> _Items = [];

  List<Item> get Items {
    return [..._Items];
  }

  Future<void> itemFetch() async {
    try {
      const url = 'https://demo.azinova.me/machine-test/api/get_items';

      final response = await http.get(Uri.parse(url));
      final addItems = json.decode(response.body);
      List<Item> datas = [];
      // print(addItems.toString());
      for (var dataJson in addItems['items']) {
        DbHelper.iteminsert('items', {
          'itemName': dataJson['itemName'],
          'itemImage': dataJson['itemImage'],
          'itemDetails': dataJson['itemDetails']
        });
        datas.add(Item.fromJson(dataJson));
      }

      _Items = datas;
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> fetchOfflineData() async {
    final dataList = await DbHelper.getData('items');
    _Items = dataList
        .map((item) => Item(
            itemImage: item['itemImage'],
            itemName: item['itemName'],
            itemDetails: item['itemDetails']))
        .toList();
    print(_Items);
    print("Data");
    notifyListeners();
  }
}
