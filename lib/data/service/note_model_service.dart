import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:note_app/data/datamodel/data.dart';
import 'package:note_app/data/service/get_all_notes_resp/get_all_notes_resp.dart';
import 'package:note_app/data/url.dart';

abstract class ApiCall {
  Future<NoteModel?> createNote(NoteModel value);
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel?> updateNote(NoteModel value);
  Future<void> deleteNote(String id);
}

class NoteDB extends ApiCall {
  // == singleton

  static final NoteDB instance = NoteDB._();

  late final Dio dio;
  final url = Url();
  final ValueNotifier<List<NoteModel>> notenotifierLisnter = ValueNotifier([]);

  NoteDB._() {
    dio = Dio(
      BaseOptions(
        baseUrl: url.basUrl, // << Make sure this is set
        responseType: ResponseType.plain,
      ),
    );
  }

  // Factory constructor
  factory NoteDB() => instance;

  @override
  Future<NoteModel?> createNote(NoteModel value) async {
    try {
      final result = await dio.post(url.createNote, data: value.toJson());
      final _resultAsJsono = jsonDecode(result.data);

      final note = NoteModel.fromJson(_resultAsJsono as Map<String, dynamic>);
      notenotifierLisnter.value.insert(0, note);
      notenotifierLisnter.notifyListeners();
      return note;
    } on DioError catch (e) {
      return null;
    } catch (e) {}
  }

  @override
  Future<void> deleteNote(String id) async {
    final result = await dio.delete(url.deleteNote.replaceFirst('{id}', id));
    if (result == null) {
      return;
    } else {
      final index = notenotifierLisnter.value.indexWhere(
        (note) => note.id == id,
      );
      if (index == -1) {
        return;
      }

      notenotifierLisnter.value.removeAt(index);
      notenotifierLisnter.notifyListeners();
    }
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    final _result = await dio.get(url.basUrl + url.getAllNote);
    if (_result.data != null) {
      final _resultAsjson = jsonDecode(_result.data);
      final getNotResp = GetAllNotesResp.fromJson(_resultAsjson);

      notenotifierLisnter.value.clear();
      notenotifierLisnter.value.addAll(getNotResp.data.reversed);

      return getNotResp.data;
    } else {
      notenotifierLisnter.value.clear();

      return [];
    }
  }

  @override
  Future<NoteModel?> updateNote(NoteModel value) async {
    final result = await dio.put(url.updateNote, data: value.toJson());

    if (result.data == null) {
      return null;
    }
    // find the index
    final index = notenotifierLisnter.value.indexWhere(
      (note) => note.id == value.id,
    );

    if (index == -1) {
      return null;
    }

    // remove from index
    notenotifierLisnter.value.removeAt(index);
    // add note that index
    notenotifierLisnter.value.insert(index, value);
    notenotifierLisnter.notifyListeners();
    return value;
  }

  NoteModel? getNoteByID(String id) {
    try {
      return notenotifierLisnter.value.firstWhere((note) => note.id == id);
    } catch (_) {
      return null;
    }
  }
}
