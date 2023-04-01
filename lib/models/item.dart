class Item {
    final String itemImage;
    final String itemName;
    final String itemDetails;
    Item({
        required this.itemImage,
        required this.itemName,
        required this.itemDetails,
    });


    factory Item.fromJson(Map<String, dynamic> json) => Item(
        itemImage: json["itemImage"],
        itemName: json["itemName"],
        itemDetails: json["itemDetails"],
    );


}
