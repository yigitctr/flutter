import 'package:flutter/material.dart';
import 'package:sqflite_demo2/data/DbHelper.dart';

import '../models/Product.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitprice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni Ürün Ekle"),
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              buidNameField(),
              buidDescriptionField(),
              buildUnitPriceField(),
              buildSaveButton()
            ],
          ),
        ));
  }

  Widget buidNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Ürün Adı"),
      controller: txtName,
    );
  }

  Widget buidDescriptionField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Ürün Açıklaması"),
      controller: txtDescription,
    );
  }

  Widget buildUnitPriceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Birim Fiyat"),
      controller: txtUnitprice,
    );
  }

  buildSaveButton() {
    return TextButton(
        child: Text("Ekle"),
        onPressed: () {
          addProduct();
        });
  }

  void addProduct() async {
    double fiyat = 0.0;
    try {
      fiyat = double.tryParse(txtUnitprice.text)!;
      await dbHelper.insert(Product(txtName.text, txtDescription.text, fiyat));
      Navigator.pop(context, true);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
