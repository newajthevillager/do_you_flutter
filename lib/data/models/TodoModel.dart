import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class TodoModel {

  String id;
  String title;
  String description;
  String imageUrl;

  TodoModel({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  static TodoModel fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imageUrl: map['imageUrl'],
    );
  }

  static TodoModel fromSnapshot(DocumentSnapshot snap) {
    return TodoModel(
      id: snap.data['id'],
      title: snap.data['title'],
      description: snap.data['description'],
      imageUrl: snap.data['imageUrl'],
    );
  }

}