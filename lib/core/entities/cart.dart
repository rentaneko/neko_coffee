class CartItem {
  final String idProduct;
  final String iceType;
  final String variantType;
  final String sizeCup;
  final String sugarType;
  final int quantity;
  String? idUser;
  String? id;
  double totalAmount;

  CartItem({
    required this.idProduct,
    required this.iceType,
    required this.variantType,
    required this.sizeCup,
    required this.sugarType,
    required this.quantity,
    this.idUser,
    required this.id,
    required this.totalAmount,
  });
}
