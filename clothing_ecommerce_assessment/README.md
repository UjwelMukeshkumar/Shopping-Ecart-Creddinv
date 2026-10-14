# Thread & Co. (Flutter E-Commerce Demo)

  clothing store demo app.

## What this app does

- Login with demo credentials
- View products from local JSON data
- Add/remove products in watchlist
- Add/remove products in cart
- Change cart quantity and see total amount
- Checkout with dummy payment
- See order success page
- Open **Profile → My Orders** to view previous orders

## Tech used

- Flutter + Dart
- `flutter_bloc` for state management
- Clean Architecture style:
  - Presentation (UI + BLoC)
  - Domain (entities + use cases + repository contracts)
  - Data (repository implementations + data source)

## Demo login

- Email: `demo@threadco.com`
- Password: `Flutter123!`

## Run the project

```bash
flutter pub get
flutter run
```

## Useful commands

Run analyzer:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

## Project structure (quick view)

```text
lib/
  core/
  data/
    datasources/
    models/
    repositories/
  domain/
    entities/
    repositories/
    usecases/
  presentation/
    bloc/
    pages/
    widgets/
assets/
  products.json
test/
```

## Important notes

- Product list is local (`assets/products.json`)
- Product images are from remote URLs (internet may be needed for images)
- Cart, watchlist, and orders are stored in memory (reset when app restarts)
- Payment is a demo simulation (no real payment gateway)

