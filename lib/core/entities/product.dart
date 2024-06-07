class Product {
  final String id;
  final String name;
  final String ingredient;
  final String iconUrl;
  final double price;
  final double discount;
  final bool isPromo;
  final String category;

  Product({
    required this.category,
    required this.id,
    required this.name,
    required this.ingredient,
    required this.iconUrl,
    required this.price,
    required this.discount,
    required this.isPromo,
  });
}
