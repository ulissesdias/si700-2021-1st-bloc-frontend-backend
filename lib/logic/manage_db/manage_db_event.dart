import 'package:aula09_2021/model/note.dart';

abstract class ManageEvent {}

class DeleteEvent extends ManageEvent {
  int noteId;
  DeleteEvent({this.noteId});
}

class UpdateRequest extends ManageEvent {
  int noteId;
  Note previousNote;

  UpdateRequest({this.noteId, this.previousNote});
}

class UpdateCancel extends ManageEvent {}

class SubmitEvent extends ManageEvent {
  Note note;
  SubmitEvent({this.note});
}
