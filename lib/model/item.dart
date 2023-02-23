import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  String? id;
  final String name;
  final String categoryId;
  final String creatorId;
  final String? imageUrl;
  final int stock;
  final num price;

  Item(
      {required this.name,
      required this.categoryId,
      required this.creatorId,
      required this.stock,
      required this.price,
      this.imageUrl,
      this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "categoryId": categoryId,
      "creatorId": creatorId,
      "stock": stock,
      "price": price
    };
  }

  static Item fromJson(Map<String, dynamic> json) { 
    return Item(
        id: json['id'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        categoryId: json['categoryId'],
        creatorId: json['creatorId'],
        stock: json['stock'],
        price: json['price'],
      );
  }

  static CollectionReference fetchCollectionFromFirestore() =>
      FirebaseFirestore.instance.collection('items');
}
