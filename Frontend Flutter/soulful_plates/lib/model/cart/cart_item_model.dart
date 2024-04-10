import 'package:soulful_plates/network/network_interfaces/generic_model.dart';

class CartItemModel extends GenericModel {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  // Named constructor for creating an empty CartItemModel instance
  CartItemModel({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  // Named constructor for creating an instance with default (empty) values
  CartItemModel.empty()
      : id = '',
        title = '',
        quantity = 0,
        price = 0.0,
        imageUrl = '';

  @override
  CartItemModel from(json) {
    // Assuming json is a Map<String, dynamic>
    return CartItemModel.fromJson(json as Map<String, dynamic>);
  }

  static CartItemModel fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: json['price'] ?? 0.0,
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'quantity': quantity,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}
