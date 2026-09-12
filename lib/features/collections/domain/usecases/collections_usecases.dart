import 'package:courier/features/collections/domain/entities/saved_request.dart';
import 'package:courier/features/collections/domain/repositories/collections_repository.dart';

class GetSavedRequests {
  const GetSavedRequests(this._repository);

  final CollectionsRepository _repository;

  /// Sorted by folder, then name.
  List<SavedRequest> call() => _repository.getAll()
    ..sort((a, b) {
      final byFolder = a.folder.toLowerCase().compareTo(b.folder.toLowerCase());
      return byFolder != 0 ? byFolder : a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
}

class SaveRequest {
  const SaveRequest(this._repository);

  final CollectionsRepository _repository;

  Future<void> call(SavedRequest request) =>
      _repository.save(request.copyWith(updatedAt: DateTime.now()));
}

class DeleteSavedRequest {
  const DeleteSavedRequest(this._repository);

  final CollectionsRepository _repository;

  Future<void> call(String id) => _repository.delete(id);
}
