import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

const firestoreSerializable = JsonSerializable(
  converters: firestoreJsonConverters,
  explicitToJson: true,
  createFieldMap: true,
);

@firestoreSerializable
class Category {
  Category({this.id, required this.name});

  @Id()
  final String? id;

  final String name;

  factory Category.fromJson(Map<String, Object?> json) => _$CategoryFromJson(json);

  Map<String, Object?> toJson() => _$CategoryToJson(this);
}

@Collection<Category>('categories')
final categoriesRef = CategoryCollectionReference();