import 'dart:async';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product.dart';
import '../product.dart';

class DbHelper {
  late Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: creatDb);
    return eTradeDb;
  }

  void creatDb(Database db, int version) async {
    await db.execute(
        "Create Table Products(id integer primary key, name text, description text, unitPrice integer)");
  }

  Future<List<Product>> getProducts() async {
    Database db = await this.db;
    var result = await db.query("Products");
    return List.generate(result.length, (i) {
      return Product.fromObject(result[i]);
    });
  }

  Future<int> insert(Product product) async {
    Database db = await this.db;

    var result = await db.insert("Products", product.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;

    var result = await db.rawDelete("delete from products where id= $id");
    return result;
  }

  Future<int> update(Product product) async {
    Database db = await this.db;

    var result = await db.update("products", product.toMap(),
        where: "id=", whereArgs: [product.id]);
    return result;
  }
}
