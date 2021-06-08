import 'package:aula09_2021/model/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRemoteServer {
  static String uid;
  static FirebaseRemoteServer helper = FirebaseRemoteServer._createInstance();
  FirebaseRemoteServer._createInstance();

  final CollectionReference noteCollection =
      FirebaseFirestore.instance.collection("notes");

  includeUserData(String uid, String email, int idade) async {
    await noteCollection.doc(uid).set({"email": email, "idade": idade});
  }

  List _noteListFromSnapshot(QuerySnapshot snapshot) {
    List<Note> noteList = [];
    List<String> idList = [];

    for (var doc in snapshot.docs) {
      Note note = Note.fromMap(doc.data());
      note.dataLocation = 0;
      noteList.add(note);
      idList.add(doc.id);
    }
    return [noteList, idList];
  }

  Future<List<dynamic>> getNoteList() async {
    QuerySnapshot snapshot =
        await noteCollection.doc(uid).collection("my_notes").get();
    return _noteListFromSnapshot(snapshot);
  }

  insertNote(Note note) async {
    await noteCollection
        .doc(uid)
        .collection("my_notes")
        .add({"title": note.title, "description": note.description});
  }

  updateNote(String noteId, Note note) async {
    await noteCollection
        .doc(uid)
        .collection("my_notes")
        .doc("$noteId")
        .update({"title": note.title, "description": note.description});
  }

  deleteNote(int noteId) async {
    await noteCollection
        .doc(uid)
        .collection("my_notes")
        .doc("$noteId")
        .delete();
  }

  /*
  Stream
  */
  Stream get stream {
    return noteCollection
        .doc(uid)
        .collection("my_notes")
        .snapshots()
        .map(_noteListFromSnapshot);
  }
}
