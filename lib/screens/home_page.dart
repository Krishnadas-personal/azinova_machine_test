import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:machine_test/provider/Item_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/item_list.dart';
import 'local_db.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? connection;
  bool isoffline = false;

  @override
  void initState() {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      print(result.toString());
      if (result == ConnectivityResult.none) {
        setState(() {
          isoffline = true;
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('You are Offline')));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text("Item List"),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0)),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LocalItemList.routeName);
                },
                child: const Text(
                  'Local-DB',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: FutureBuilder(
          future: (isoffline)
              ? Provider.of<ItemProvider>(context, listen: false)
                  .fetchOfflineData()
              : Provider.of<ItemProvider>(context, listen: false).itemFetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.error != null) {
              return const Center(
                child: Text("An error occured contact admin"),
              );
            } else {
              return Consumer<ItemProvider>(builder: (context, item, child) {
                return ItemList(item: item.Items);
              });
            }
          },
        ),
      ),
    );
  }
}
