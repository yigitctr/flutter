class Product {
  int? id; //=0;
  String? name; //="";
  String? description; //="";
  double? unitPrice; //=0.0;

  Product(this.name, this.description, this.unitPrice) {}
  Product.withId(this.id, this.name, this.description, this.unitPrice) {}
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["unitprice"] = unitPrice;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  //                      map olarak geliyor, object e dönüşecek
  Product.fromMap(dynamic m) {
    try {
      if (m[id] != null) this.id = int.tryParse(m["id"]);
      this.name = m["name"];
      this.description = m["description"];
      this.unitPrice = double.tryParse(m["unitPrice"]);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
