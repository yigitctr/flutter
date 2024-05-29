import 'package:flutter/material.dart';
import 'package:sqflite_demo2/screens/product_detail.dart';
import '../data/DbHelper.dart';
import '../models/Product.dart';
import 'product_add.dart';

class ProductList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State {
  var dbHelper = DbHelper();
  List<Product> products = [];
  int productCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Listesi"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          gotoProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: "yeni ürün ekle",
      ),
    );
  }

  @override
  void initState() {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      this.products = data;
    });
    super.initState();
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.cyan,
            elevation: 2.0,
            child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.black12,
                  child: Text("P"),
                ),
                title: Text(this.products[position].name!),
                subtitle: Text(this.products[position].description!),
                onTap: () {
                  gotoDetails(this.products[position]);
                }),
          );
        });
  }

  void gotoProductAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    //if(result!=null) {
    if (result) {
      getProducts();
    }
    //}
  }

  void getProducts() async {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        this.products = data;
        this.productCount = data.length;
      });
    });
  }

  void gotoDetails(Product product) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    //if(result!=null){
    if (result) {
      getProducts();
    }
    //}
  }
}
