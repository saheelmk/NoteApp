import 'package:freezed_annotation/freezed_annotation.dart';

part 'data.freezed.dart';
part 'data.g.dart';

@freezed
abstract class NoteModel with _$NoteModel {
  const factory NoteModel({
    @JsonKey(name: '_id') String? id,
    required String title,
    required String content,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
}
