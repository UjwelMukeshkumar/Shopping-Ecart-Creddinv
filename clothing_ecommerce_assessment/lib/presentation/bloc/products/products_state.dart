part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  const ProductsLoaded(this.products);

  final List<Product> products;

  @override
  List<Object?> get props => [products];
}

class ProductsEmpty extends ProductsState {
  const ProductsEmpty();
}

class ProductsFailure extends ProductsState {
  const ProductsFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
