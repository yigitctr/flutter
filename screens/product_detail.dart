import '../data/DbHelper.dart';
import 'package:flutter/material.dart';
import '../models/Product.dart';

class ProductDetail extends StatefulWidget {
  Product product = Product("", "", 0.00);
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

//Enum (uzun  "enumeration" yani "numaralandırma" anlamına gelir), yazılar numaralandırılır
enum Options { delete, update }

class _ProductDetailState extends State {
  var dbHelper = DbHelper();
  Product product;
  _ProductDetailState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün detayı: ${product.name}"),
        // column gibi row gibi çalışan action: parametresi
        actions: <Widget>[
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Sil"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Güncelle"),
              ),
            ],
          )
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {}

  void selectProcess(Options options) async {
    //print(value);
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id!);
        Navigator.pop(context, true);
        break;
      default:
        break;
    }
  }
}
