import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:siksik_labuyo/model/category.dart';
import 'package:siksik_labuyo/model/creator.dart';

part 'item.g.dart';

const firestoreSerializable = JsonSerializable(
  converters: firestoreJsonConverters,
  explicitToJson: true,
  createFieldMap: true,
);

@firestoreSerializable
class Item {
  Item(
    {
      this.id,
      required this.name,
      required this.categoryId,
      required this.creatorId,
      required this.price,
      required this.stock,
      this.imageUrl
    }
    );

  @Id()
  final String? id;

  final String name;
  final String categoryId;
  final String creatorId;
  final double price;
  final int stock;
  final String? imageUrl;

  Future<Category> getCategory() async {
    return await categoriesRef.doc(categoryId).get().then((value) => value.data!);
  }

  Future<Creator> getCreator() async {
    return await creatorsRef.doc(creatorId).get().then((value) => value.data!);
  }
}

@Collection<Item>('items')
final itemsRef = ItemCollectionReference();