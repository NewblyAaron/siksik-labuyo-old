import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  String? id;
  final String name;

  Category({required this.name, this.id});

  factory Category.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ) {
    final data = snapshot.data();

    return Category(
      id: data?['id'],
      name: data?['name'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      "name": name,
    };
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
    };
  }

  static Category fromJson(Map<String, dynamic> json) => Category(
        id: json['id'],
        name: json['name'],
      );

  static CollectionReference fetchCollectionFromFirestore() => FirebaseFirestore.instance.collection('categories');
}
