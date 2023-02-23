import 'package:cloud_firestore/cloud_firestore.dart';

class Creator {
  String? id;
  final String name;

  Creator({required this.name, this.id});

  factory Creator.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ) {
    final data = snapshot.data();

    return Creator(
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

  static Creator fromJson(Map<String, dynamic> json) => Creator(
        id: json['id'],
        name: json['name'],
      );
      
  static CollectionReference fetchCollectionFromFirestore() => FirebaseFirestore.instance.collection('creators');
}
