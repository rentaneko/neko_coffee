class CartItem {
  final String? id;
  final String idProduct;
  final List<String>? idTopping;
  final String iceType;
  final String variantType;
  final String sizeCup;
  final String sugarType;
  final int quantity;
  final String? idUser;

  CartItem({
    this.id,
    required this.idProduct,
    required this.idTopping,
    required this.iceType,
    required this.variantType,
    required this.sizeCup,
    required this.sugarType,
    required this.quantity,
    this.idUser,
  });
}
