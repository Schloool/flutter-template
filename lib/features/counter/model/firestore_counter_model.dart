import 'package:flutter_template/core/firebase/firestore/model/firestore_model.dart';
import 'package:flutter_template/core/firebase/firestore/model/firestore_model_factory.dart';
import 'package:flutter_template/features/counter/model/counter_model.dart';

class FirestoreCounterModel extends CounterModel implements FirestoreModel {
  FirestoreCounterModel(super.value, {required this.id});

  @override
  final String id;

  @override
  Map<String, dynamic> toFirestore() => {'value': value};
}

class FirestoreCounterModelFactory
    extends FirestoreModelFactory<FirestoreCounterModel> {
  @override
  FirestoreCounterModel fromFirestore(String id, Map<String, dynamic> data) =>
      FirestoreCounterModel(data['value'] as int, id: id);
}
