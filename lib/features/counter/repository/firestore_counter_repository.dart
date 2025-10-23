import 'package:flutter_template/core/firebase/firestore/repository/firestore_repository.dart';
import 'package:flutter_template/features/counter/model/firestore_counter_model.dart';
import 'package:flutter_template/features/counter/repository/counter_repository.dart';

class FirestoreCounterRepository
    extends FirestoreRepository<FirestoreCounterModel>
    implements CounterRepository {
  FirestoreCounterRepository({
    required super.modelFactory,
    super.path = 'counter',
  });

  @override
  Future<int> getInitialCount() async {
    final value = await getById('stored-count');
    return value?.count ?? 0;
  }
}
