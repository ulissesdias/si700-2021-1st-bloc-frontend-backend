import 'package:aula09_2021/logic/manage_auth/auth_bloc.dart';
import 'package:aula09_2021/logic/manage_auth/auth_event.dart';
import 'package:aula09_2021/logic/manage_db/manage_db_state.dart';
import 'package:aula09_2021/logic/manage_db/manage_firebase_db_bloc.dart';
import 'package:aula09_2021/logic/manage_db/manage_local_db_bloc.dart';
import 'package:aula09_2021/logic/manage_db/manage_remote_db_bloc.dart';
import 'package:aula09_2021/logic/monitor_db/monitor_db_bloc.dart';
import 'package:aula09_2021/view/notes/note_list.dart';
import 'package:aula09_2021/view/notes/notes_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentPage = 0;

  var _pages = [
    NoteList(),
    NotesEntry<ManageLocalBloc>(),
    NotesEntry<ManageRemoteBloc>(),
    NotesEntry<ManageFirebaseBloc>()
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MonitorBloc()),
        BlocProvider(create: (_) => ManageLocalBloc()),
        BlocProvider(create: (_) => ManageRemoteBloc()),
        BlocProvider(create: (_) => ManageFirebaseBloc())
      ],
      child: BlocListener<ManageLocalBloc, ManageState>(
        listener: (context, state) {
          if (state is UpdateState) {
            setState(() {
              _currentPage = 1;
            });
          }
        },
        child: BlocListener<ManageRemoteBloc, ManageState>(
          listener: (context, state) {
            if (state is UpdateState) {
              setState(() {
                _currentPage = 2;
              });
            }
          },
          child: BlocListener<ManageFirebaseBloc, ManageState>(
            listener: (context, state) {
              if (state is UpdateState) {
                setState(() {
                  _currentPage = 3;
                });
              }
            },
            child: Scaffold(
              body: _pages[_currentPage],
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_balance_wallet), label: "View"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_balance_wallet), label: "Local"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_balance_wallet),
                      label: "Remote"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_balance_wallet),
                      label: "Firebase"),
                ],
                currentIndex: _currentPage,
                onTap: (int novoIndex) {
                  setState(() {
                    _currentPage = novoIndex;
                  });
                },
                fixedColor: Colors.red,
              ),
              appBar: AppBar(
                title: Text("Minhas Anotações"),
                actions: [
                  TextButton.icon(
                      style: TextButton.styleFrom(primary: Colors.white),
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(Logout());
                      },
                      label: Text("Logout"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
