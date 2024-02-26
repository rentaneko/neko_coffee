import 'package:neko_coffee/models/cart.model.dart';

int getQuantityInCartById(String id, List<CartModel> cart) {
  for (var item in cart) {
    if (item.idProduct == id) {
      return item.quantity!;
    }
  }
  return 0;
}
