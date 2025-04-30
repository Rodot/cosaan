import 'package:freezed_annotation/freezed_annotation.dart';

part 'log_model.freezed.dart';
part 'log_model.g.dart';

@freezed
abstract class Log with _$Log {
  const factory Log({
    required String id,
    required String content,
    required String roomId,
    required DateTime createdAt,
  }) = _Log;

  factory Log.fromJson(Map<String, dynamic> json) => _$LogFromJson(json);
}
