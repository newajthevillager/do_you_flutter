import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iremember/data/models/TodoModel.dart';

abstract class TodoRepository {
  Future<void> addTodo(TodoModel todo);

  Future<void> deleteTodo(TodoModel todo);

  Future<void> updateTodo(TodoModel todo);

  Stream<List<TodoModel>> getTodos();
}

class TodoRepositoryImpl implements TodoRepository {
  CollectionReference todoCollection = Firestore.instance.collection('todos');

  @override
  Future<void> addTodo(TodoModel todo) async {
    await Firestore.instance.runTransaction((_) async {
      await todoCollection.add(todo.toMap());
    });
  }

  @override
  Future<void> deleteTodo(TodoModel todo) async {
    await todoCollection.document(todo.id).delete();
  }

  @override
  Stream<List<TodoModel>> getTodos() {
    return todoCollection.snapshots().map((querySnapshot) {
      return querySnapshot.documents.map((documentSnap) {
        return TodoModel.fromSnapshot(documentSnap);
      }).toList();
    });
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    todoCollection.document(todo.id).updateData(todo.toMap());
  }
}
