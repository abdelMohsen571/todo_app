// related to firebade ;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_tasks/data/to_do.dart';

Future<void> addTodoToFirebase(
    String title, String description, DateTime dateTime) {
  CollectionReference<Todo> collectionReference = getTodoCollectionRefrence();

  DocumentReference<Todo> documentReference = collectionReference.doc();

  Todo item = Todo(
      id: documentReference.id,
      title: title,
      description: description,
      dateTime: dateTime);
  return documentReference.set(item);
}

Future<void> deleteTodoFromFirebase(Todo item) {
  CollectionReference<Todo> collectionReference = getTodoCollectionRefrence();
  DocumentReference<Todo> documentReference = collectionReference.doc(item.id);
  return documentReference.delete();
}

CollectionReference<Todo> getTodoCollectionRefrence() {
  return FirebaseFirestore.instance
      .collection(Todo.collectionName)
      .withConverter<Todo>(
        fromFirestore: (snapshot, _) => Todo.fromJson(snapshot.data()!),
        toFirestore: (item, _) => item.toJson(),
      );
}
