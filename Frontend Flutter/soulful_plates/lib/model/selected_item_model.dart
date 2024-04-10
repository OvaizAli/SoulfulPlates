class SelectedItemModel {
  int menuItemId;
  String itemName;
  int quantity;
  String price;

  SelectedItemModel({
    required this.menuItemId,
    required this.itemName,
    required this.quantity,
    required this.price,
  });

  factory SelectedItemModel.fromJson(Map<String, dynamic> json) {
    return SelectedItemModel(
      menuItemId: json['menuItemId'] as int,
      itemName: json['itemName'] as String,
      quantity: json['quantity'] as int,
      price: json['price'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuItemId'] = menuItemId;
    data['itemName'] = itemName;
    data['quantity'] = quantity;
    data['price'] = double.tryParse(price) ?? 0;
    return data;
  }

  double calculateSubtotal() {
    return quantity * (double.tryParse(price) ?? 0);
  }
}
