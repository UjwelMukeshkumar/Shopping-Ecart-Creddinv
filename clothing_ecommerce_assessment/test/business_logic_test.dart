import 'package:flutter_test/flutter_test.dart';
import 'package:clothing_ecommerce_assessment/data/repositories/auth_repository_impl.dart';
import 'package:clothing_ecommerce_assessment/data/repositories/cart_repository_impl.dart';
import 'package:clothing_ecommerce_assessment/data/repositories/watchlist_repository_impl.dart';
import 'package:clothing_ecommerce_assessment/domain/entities/product.dart';

const sampleProduct = Product(
    id: 'p1', name: 'Tee', subtitle: 'Cotton', price: 500, imageUrl: '');
void main() {
  group('Dummy login', () {
    final repository = AuthRepositoryImpl();
    test('accepts the predefined demo credentials', () async {
      expect(
          await repository.login(
              email: 'demo@threadco.com', password: 'Flutter123!'),
          isTrue);
    });
    test('rejects incorrect credentials', () async {
      expect(
          await repository.login(
              email: 'wrong@example.com', password: 'badpassword'),
          isFalse);
    });
  });
  group('Cart business logic', () {
    test('adding the same product increments quantity and total is correct',
        () async {
      final repo = CartRepositoryImpl();
      await repo.add(sampleProduct);
      final items = await repo.add(sampleProduct);
      expect(items.single.quantity, 2);
      expect(items.fold<double>(0, (sum, item) => sum + item.lineTotal), 1000);
    });
    test('setting quantity to zero removes item', () async {
      final repo = CartRepositoryImpl();
      await repo.add(sampleProduct);
      final items = await repo.updateQuantity('p1', 0);
      expect(items, isEmpty);
    });
  });
  group('Watchlist business logic', () {
    test('adds and removes a product', () async {
      final repo = WatchlistRepositoryImpl();
      expect((await repo.add(sampleProduct)).length, 1);
      expect(await repo.remove('p1'), isEmpty);
    });
  });
}
