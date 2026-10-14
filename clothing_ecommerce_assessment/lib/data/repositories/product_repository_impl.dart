import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/local_product_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this.dataSource);
  final LocalProductDataSource dataSource;
  @override
  Future<List<Product>> getProducts() => dataSource.getProducts();
}
