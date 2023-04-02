import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:machine_test/provider/Item_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/item_list.dart';

class LocalItemList extends StatefulWidget {
  static const routeName = '/LocalItemList';
  const LocalItemList({super.key});

  @override
  State<LocalItemList> createState() => _LocalItemListState();
}

class _LocalItemListState extends State<LocalItemList> {
  @override
  void initState() {
    Provider.of<ItemProvider>(context, listen: false).fetchOfflineData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = Provider.of<ItemProvider>(context).Items;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Local DB Item List"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0)),
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(items[index].itemImage),
            ),
            title: Text(items[index].itemName),
            subtitle: Text(items[index].itemDetails),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
