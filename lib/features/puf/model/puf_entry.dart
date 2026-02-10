import 'package:freezed_annotation/freezed_annotation.dart';

part 'puf_entry.freezed.dart';
part 'puf_entry.g.dart';

@freezed
class PufEntry with _$PufEntry {
  const factory PufEntry({
    required String pufU1Id,
    required String message,
    required int status,
  }) = _PufEntry;

  factory PufEntry.fromJson(Map<String, dynamic> json) => _$PufEntryFromJson(json);
}

@freezed
class PufEntryRequest with _$PufEntryRequest {
  const factory PufEntryRequest({
    required String barcodeScan,
  }) = _PufEntryRequest;

  factory PufEntryRequest.fromJson(Map<String, dynamic> json) => 
      _$PufEntryRequestFromJson(json);
}
