class Topping {
  final String id;
  final String idCategory;
  final String name;
  final double price;
  final String description;
  bool value;
  Topping({
    required this.id,
    required this.idCategory,
    required this.name,
    required this.price,
    required this.description,
    this.value = false,
  });
}
