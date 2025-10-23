import 'package:flutter_template/core/firebase/firestore/model/firestore_model.dart';

abstract class FirestoreModelFactory<T extends FirestoreModel> {
  T fromFirestore(String id, Map<String, dynamic> data);
}
