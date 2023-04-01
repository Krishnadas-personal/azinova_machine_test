import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ItemList extends StatelessWidget {
  final item;
  const ItemList({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (itemBuilder, index) {
        return InkWell(
          onTap: () {
            // Navigator.pushNamed(context, CoreData.routeName);
          },
          child: Card(
            elevation: 3.0,
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.network(item[index].itemImage),
                ),
                ListTile(
                  title: Text(item[index].itemName),
                  subtitle: Text(item[index].itemDetails),
                )
              ],
            ),
          ),
        );
      },
      itemCount: item.length,
    );
  }
}
