import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_template/core/firebase/firestore/model/firestore_model.dart';
import 'package:flutter_template/core/firebase/firestore/model/firestore_model_factory.dart';

class FirestoreRepository<T extends FirestoreModel> {
  FirestoreRepository({required this.path, required this.modelFactory});

  final String path;
  final FirestoreModelFactory<T> modelFactory;

  CollectionReference<T> get _collection => FirebaseFirestore.instance
      .collection(path)
      .withConverter<T>(
        fromFirestore:
            (snapshot, _) =>
                modelFactory.fromFirestore(snapshot.id, snapshot.data()!),
        toFirestore: (T value, _) => value.toFirestore(),
      );

  Stream<List<T>> streamAll() {
    return _collection.snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  Future<List<T>> getAll() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<T?> getById(String id) async {
    final doc = await _collection.doc(id).get();
    return doc.data();
  }

  Future<void> add(T item) async {
    await _collection.doc(item.id).set(item);
  }

  Future<void> update(T item) async {
    await _collection.doc(item.id).set(item, SetOptions(merge: true));
  }

  Future<void> delete(String id) async {
    await _collection.doc(id).delete();
  }
}
