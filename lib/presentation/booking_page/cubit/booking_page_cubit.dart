import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_tour_booking_app/presentation/booking_page/cubit/booking_page_states.dart';
import 'package:sqflite/sqflite.dart';

class BookingPageCubit extends Cubit<BookingPageStates> {
  BookingPageCubit() : super(BookingInitialStates());

  List<Map> savedTours = [];

  late Database database;

  void createDataBase() async {
    await openDatabase(
      'tour.db',
      version: 1,
      onCreate: (database, version) async {
        print('Database Created');
        await database
            .execute(
              'CREATE TABLE tours (id INTEGER PRIMARY KEY, title TEXT, desc TEXT, img TEXT, price TEXT)',
            )
            .then((value) {
              print('Table Created');
            })
            .catchError((error) {
              print('Error when creating table: ${error.toString()}');
            });
      },
      onOpen: (db) {
        print('Database Opened');
        getDataFromDatabase(db);
      },
    ).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });
  }

  void insertToDatabase({
    required String title,
    required String desc,
    required String img,
    required String price,
  }) async {
    if (!database.isOpen) {
      print('Database is not open yet!');
      return;
    }

    try {
      await database.transaction((txn) async {
        await txn.rawInsert(
          'INSERT INTO tours(title, desc, img, price) VALUES(?, ?, ?, ?)',
          [title, desc, img, price],
        );
      });

      getDataFromDatabase(database);
      emit(InsertDataBaseState());
      print('Inserted successfully');
    } catch (error) {
      print('Insert Error: ${error.toString()}');
    }
  }

  void getDataFromDatabase(Database database) {
    savedTours = [];

    database.rawQuery('SELECT * FROM tours').then((value) {
      value.forEach((element) {
        savedTours.add(element);
      });
      emit(GetDataBaseState());
    });
  }

  Future<void> deleteDate({required int id}) async {
    await database.rawDelete('DELETE FROM tours WHERE id = ?', [id]);
    getDataFromDatabase(database);
    emit(DeleteDataState());
  }
}
