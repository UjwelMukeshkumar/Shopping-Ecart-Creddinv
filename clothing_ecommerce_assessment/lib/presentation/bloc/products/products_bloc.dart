import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_products.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(this.getProducts) : super(const ProductsInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(const ProductsLoading());
      try {
        final products = await getProducts();
        emit(products.isEmpty
            ? const ProductsEmpty()
            : ProductsLoaded(products));
      } catch (_) {
        emit(const ProductsFailure(
            'Could not load products. Check the local JSON asset and try again.'));
      }
    });
  }
  final GetProducts getProducts;
}
