import 'package:hive/hive.dart';
part 'cart_item.g.dart'; 

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final int productId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final String thumbnail;

  @HiveField(5)
  int quantity; 

  CartItem({
    required this.username,
    required this.productId,
    required this.title,
    required this.price,
    required this.thumbnail,
    required this.quantity,
  });
}