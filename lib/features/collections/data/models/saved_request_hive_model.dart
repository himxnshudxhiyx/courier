import 'package:courier/features/collections/domain/entities/saved_request.dart';
import 'package:courier/shared/data/models/request_hive_models.dart';

class SavedRequestHiveModel {
  const SavedRequestHiveModel({
    required this.id,
    required this.name,
    required this.folder,
    required this.request,
    required this.updatedAtMs,
  });

  final String id;
  final String name;
  final String folder;
  final RequestHiveModel request;
  final int updatedAtMs;

  factory SavedRequestHiveModel.fromEntity(SavedRequest e) => SavedRequestHiveModel(
        id: e.id,
        name: e.name,
        folder: e.folder,
        request: RequestHiveModel.fromEntity(e.request),
        updatedAtMs: e.updatedAt.millisecondsSinceEpoch,
      );

  SavedRequest toEntity() => SavedRequest(
        id: id,
        name: name,
        folder: folder,
        request: request.toEntity(),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAtMs),
      );
}
