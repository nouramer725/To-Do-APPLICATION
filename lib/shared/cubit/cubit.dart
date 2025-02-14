import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import '../../Archive_screen.dart';
import '../../Done_screen.dart';
import '../../New_Screen.dart';
import 'states.dart';


class APPCubit extends Cubit<AppStates> {
  APPCubit() : super(AppIntialState());

  static APPCubit get(context) => BlocProvider.of(context);

  Database? database;

  List<Map> tasks = [];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  int currentIndex = 0;

  List<Widget> screens = [
    const NewScreen(),
    const DoneScreen(),
    const ArchivedScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase() {
    openDatabase(
      'Task.db',
      version: 1,
      onCreate: (database, version) {
        database.execute(
          'CREATE TABLE Task(id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT, status TEXT)',
        ).then((value) {
          if (kDebugMode) {
            print('table created');
          }
        }).catchError((error) {
          if (kDebugMode) {
            print('Error When Creating Table ${error.toString()}');
          }
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDataBase());
    });
  }

  Future<void> insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database!.transaction((txn) async {
      await txn.rawInsert(
        'INSERT INTO Task(title, time, date, status) VALUES(?, ?, ?, ?)',
        [title, time, date, 'new'],
      ).then((value) {
        if (kDebugMode) {
          print('$value inserted successfully');
        }
        emit(AppInsertDataBase());
        getDataFromDatabase(database);
      }).catchError((error) {
        if (kDebugMode) {
          print('Error inserting new record: ${error.toString()}');
        }
      });
    });
  }

  Future<void> updateTaskStatus({required int id, required String status}) async {
    await database!.rawUpdate(
      'UPDATE Task SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      getDataFromDatabase(database);  // Refresh the task list
      emit(AppUpdateDatabaseState());
    }).catchError((error) {
      if (kDebugMode) {
        print('Error updating task status: ${error.toString()}');
      }
    });
  }

  Future<void> deleteTask({required int id}) async {
    await database!.rawDelete(
      'DELETE FROM Task WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);  // Refresh the task list
      emit(AppDeleteDatabaseState());
    }).catchError((error) {
      if (kDebugMode) {
        print('Error deleting task: ${error.toString()}');
      }
    });
  }

  Future<void> getDataFromDatabase(database) async {
    database!.rawQuery('SELECT * FROM Task').then((value) {
      tasks = value;
      emit(AppGetDataBase());
    }).catchError((error) {
      if (kDebugMode) {
        print('Error getting data from database: ${error.toString()}');
      }
    });
  }
}
