import 'package:courier/shared/domain/entities/api_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_request.freezed.dart';

@freezed
abstract class SavedRequest with _$SavedRequest {
  const factory SavedRequest({
    required String id,
    required String name,
    @Default('') String folder,
    required ApiRequest request,
    required DateTime updatedAt,
  }) = _SavedRequest;
}
