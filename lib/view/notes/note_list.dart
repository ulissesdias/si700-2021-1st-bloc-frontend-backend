import 'package:aula09_2021/logic/manage_db/manage_db_event.dart';
import 'package:aula09_2021/logic/manage_db/manage_firebase_db_bloc.dart';
import 'package:aula09_2021/logic/manage_db/manage_local_db_bloc.dart';
import 'package:aula09_2021/logic/manage_db/manage_remote_db_bloc.dart';
import 'package:aula09_2021/logic/monitor_db/monitor_db_state.dart';
import 'package:aula09_2021/logic/monitor_db/monitor_db_bloc.dart';
import 'package:aula09_2021/model/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NoteListState();
  }
}

class _NoteListState extends State<NoteList> {
  List colorLocation = [Colors.red, Colors.blue, Colors.yellow];
  List iconLocation = [
    Icons.error_outline,
    Icons.settings_cell,
    Icons.network_check_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonitorBloc, MonitorState>(builder: (context, state) {
      return getNoteListView(state.noteList, state.idList);
    });
  }

  ListView getNoteListView(noteList, idList) {
    return ListView.builder(
      itemCount: noteList.length,
      itemBuilder: (context, position) {
        return Card(
          color: colorLocation[noteList[position].dataLocation],
          elevation: 5,
          child: ListTile(
            leading: Icon(iconLocation[noteList[position].dataLocation]),
            title: Text(noteList[position].title),
            subtitle: Text(noteList[position].description),
            onTap: () {
              if (noteList[position].dataLocation == 1) {
                BlocProvider.of<ManageLocalBloc>(context).add(UpdateRequest(
                    noteId: idList[position],
                    previousNote: Note.fromMap(noteList[position].toMap())));
              } else if (noteList[position].dataLocation == 2) {
                BlocProvider.of<ManageRemoteBloc>(context).add(UpdateRequest(
                    noteId: idList[position],
                    previousNote: Note.fromMap(noteList[position].toMap())));
              } else if (noteList[position].dataLocation == 0) {
                BlocProvider.of<ManageFirebaseBloc>(context).add(UpdateRequest(
                    noteId: idList[position],
                    previousNote: Note.fromMap(noteList[position].toMap())));
              }
            },
            trailing: GestureDetector(
                onTap: () {
                  if (noteList[position].dataLocation == 1) {
                    BlocProvider.of<ManageLocalBloc>(context)
                        .add(DeleteEvent(noteId: idList[position]));
                  } else if (noteList[position].dataLocation == 2) {
                    BlocProvider.of<ManageRemoteBloc>(context)
                        .add(DeleteEvent(noteId: idList[position]));
                  } else if (noteList[position].dataLocation == 0) {
                    BlocProvider.of<ManageFirebaseBloc>(context)
                        .add(DeleteEvent(noteId: idList[position]));
                  }
                },
                child: Icon(Icons.delete)),
          ),
        );
      },
    );
  }
}
