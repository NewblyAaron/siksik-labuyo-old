import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_odm/cloud_firestore_odm.dart';
import 'package:json_annotation/json_annotation.dart';

part 'creator.g.dart';

const firestoreSerializable = JsonSerializable(
  converters: firestoreJsonConverters,
  explicitToJson: true,
  createFieldMap: true,
);

@firestoreSerializable
class Creator {
  Creator({this.id, required this.name});

  @Id()
  final String? id;

  final String name;

  factory Creator.fromJson(Map<String, Object?> json) => _$CreatorFromJson(json);

  Map<String, Object?> toJson() => _$CreatorToJson(this);
}

@Collection<Creator>('creators')
final creatorsRef = CreatorCollectionReference();