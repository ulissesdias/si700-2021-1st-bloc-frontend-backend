import 'dart:convert';

import 'package:aula09_2021/model/note.dart';
import 'package:dio/dio.dart';

class DatabaseRemoteServer {
  /* 
    Criando singleton
  */
  static DatabaseRemoteServer helper = DatabaseRemoteServer._createInstance();
  DatabaseRemoteServer._createInstance();

  String databaseUrl = "http://192.168.15.14:3000/notes";

  Dio _dio = Dio();

  Future<List<dynamic>> getNoteList() async {
    Response response = await _dio.request(this.databaseUrl,
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));
    List<Note> noteList = [];
    List<int> idList = [];

    response.data.forEach((element) {
      element["dataLocation"] = 2;
      Note note = Note.fromMap(element);
      noteList.add(note);
      idList.add(element["id"]);
    });

    return [noteList, idList];
  }

  Future<int> insertNote(Note note) async {
    await _dio.post(this.databaseUrl,
        options: Options(headers: {"Accept": "application/json"}),
        data:
            jsonEncode({"title": note.title, "description": note.description}));
    return 1;
  }

  Future<int> updateNote(int noteId, Note note) async {
    await _dio.put(this.databaseUrl + "/$noteId",
        options: Options(headers: {"Accept": "application/json"}),
        data:
            jsonEncode({"title": note.title, "description": note.description}));
    return 1;
  }

  Future<int> deleteNote(int noteId) async {
    await _dio.delete(this.databaseUrl + "/$noteId",
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));
    return 1;
  }
}

void main() async {
  DatabaseRemoteServer noteService = DatabaseRemoteServer.helper;
  /*
  var response = await noteService.getNoteList();
  Note note = response[0][0];
  print(note.title);
  */

  Note note = Note();
  note.title = "Gabriel Gomes";
  note.description = "Aluno de SI700";
  //noteService.insertNote(note);
  //noteService.updateNote(0, note);
  noteService.deleteNote(1);
}
