import 'package:courier/features/collections/domain/entities/saved_request.dart';

abstract interface class CollectionsRepository {
  List<SavedRequest> getAll();

  /// Inserts or replaces by id.
  Future<void> save(SavedRequest request);

  Future<void> delete(String id);
}
