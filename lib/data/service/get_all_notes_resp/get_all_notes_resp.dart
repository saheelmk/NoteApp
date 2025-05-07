import 'package:json_annotation/json_annotation.dart';

import 'package:note_app/data/datamodel/data.dart';

part 'get_all_notes_resp.g.dart';

@JsonSerializable()
class GetAllNotesResp {
  @JsonKey(name: 'data')
  List<NoteModel> data;

  GetAllNotesResp({this.data = const []});

  factory GetAllNotesResp.fromJson(Map<String, dynamic> json) {
    return _$GetAllNotesRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetAllNotesRespToJson(this);
}
