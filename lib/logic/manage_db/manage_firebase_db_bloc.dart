import 'package:aula09_2021/data/firebase/firebase_database.dart';
import 'package:aula09_2021/logic/manage_db/manage_db_event.dart';
import 'package:aula09_2021/logic/manage_db/manage_db_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageFirebaseBloc extends Bloc<ManageEvent, ManageState> {
  ManageFirebaseBloc() : super(InsertState());

  @override
  Stream<ManageState> mapEventToState(ManageEvent event) async* {
    if (event is DeleteEvent) {
      FirebaseRemoteServer.helper.deleteNote(event.noteId);
    } else if (event is UpdateRequest) {
      yield UpdateState(noteId: event.noteId, previousNote: event.previousNote);
    } else if (event is UpdateCancel) {
      yield InsertState();
    } else if (event is SubmitEvent) {
      if (state is InsertState) {
        FirebaseRemoteServer.helper.insertNote(event.note);
      } else if (state is UpdateState) {
        UpdateState updateState = state;
        FirebaseRemoteServer.helper.updateNote(updateState.noteId, event.note);
        yield InsertState();
      }
    }
  }
}
