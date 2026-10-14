import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({required this.id, required this.name, required this.subtitle, required this.price, required this.imageUrl});
  final String id, name, subtitle, imageUrl;
  final double price;
  @override
  List<Object?> get props => [id, name, subtitle, price, imageUrl];
}
