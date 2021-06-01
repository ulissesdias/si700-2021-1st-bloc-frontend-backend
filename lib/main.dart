import 'package:aula09_2021/logic/manage_db/manage_db_state.dart';
import 'package:aula09_2021/logic/manage_db/manage_local_db_bloc.dart';
import 'package:aula09_2021/logic/manage_db/manage_remote_db_bloc.dart';
import 'package:aula09_2021/logic/monitor_db/monitor_db_bloc.dart';
import 'package:aula09_2021/view/note_list.dart';
import 'package:aula09_2021/view/notes_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _currentPage = 0;

  var _pages = [
    NoteList(),
    NotesEntry<ManageLocalBloc>(),
    NotesEntry<ManageRemoteBloc>()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => MonitorBloc()),
          BlocProvider(create: (_) => ManageLocalBloc()),
          BlocProvider(create: (_) => ManageRemoteBloc())
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
            child: Scaffold(
              body: _pages[_currentPage],
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_balance_wallet), label: "View"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_balance_wallet),
                      label: "Manage Local"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_balance_wallet),
                      label: "Manage Remote"),
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
