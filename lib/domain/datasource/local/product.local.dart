import 'package:hive/hive.dart';

import '../../models/product.model.dart';

abstract interface class ProductLocalDataSource {
  void uploadLocalProduct({required List<ProductModel> products});

  List<ProductModel> loadProduct();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final Box box;

  ProductLocalDataSourceImpl(this.box);

  @override
  List<ProductModel> loadProduct() {
    List<ProductModel> products = [];
    box.read(() {
      for (var i = 0; i < box.length; i++) {
        products.add(ProductModel.fromJson(box.get(i.toString())));
      }
    });
    return products;
  }

  @override
  void uploadLocalProduct({required List<ProductModel> products}) {
    box.clear();
    box.write(() {
      for (var i = 0; i < products.length; i++) {
        box.put(i.toString(), products[i].toJson());
      }
    });
  }
}
