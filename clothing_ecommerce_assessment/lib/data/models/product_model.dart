import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel(
      {required super.id,
      required super.name,
      required super.subtitle,
      required super.price,
      required super.imageUrl});
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as String,
        name: json['name'] as String,
        subtitle: json['subtitle'] as String,
        price: (json['price'] as num).toDouble(),
        imageUrl: json['imageUrl'] as String,
      );
}
