import 'dart:developer';

import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';

import '../../app/constants/strings.dart';
import 'local_database_reposetory.dart';

class LocalDatabaseReposetoryImpl extends LocalDatabaseReposetory {
  const LocalDatabaseReposetoryImpl();

  static Database? _database;

  void initDB() async {
    if (_database != null) return;
    //? lazily instantiate the db the first time it is accessed
    await connection()
        .then(
          (db) => _database = db,
        )
        .catchError(
          (error) => throw Exception("Error when cocnnection database: $error"),
        );
  }

  @override
  Future<Database> connection() async {
    final String path = await getDatabasesPath();
    final String databasesPath = join(path, databaseName);
    return await openDatabase(
      databasesPath,
      version: databaseVersion,
      onCreate: createTable,
    );
  }

  @override
  Future<void> createTable(Database db, int verstion) async {
    await db
        .execute(
          '''CREATE TABLE $cardsTable 
          ($colId INTEGER PRIMARY KEY, $colProductId INTEGER NOT NULL, $colTitle TEXT NOT NULL, $colDesc TEXT NOT NULL,
           $colImage TEXT NOT NULL, $colCategory TEXT NOT NULL, $colPrice num NOT NULL, $colQuantity INTEGER NOT NULL,
           $colDataTime TEXT NOT NULL)''',
        )
        .then((_) => log("Execute Create Table Successfully"))
        .catchError(
          (error) => log("$error", name: "Error when Execute Create Table"),
        );
  }

  //*___________________________________ Branch Records of Queries ___________________________________//

  @override
  Future<List<Map<String, Object?>>> readRecords() async {
    if (_database == null) return [];
    return await _database!.query(cardsTable).then((value) {
      log("Read all records Successfully");
      return value;
    }).catchError(
      (error) => throw Exception("Error when reads all records: $error"),
    );
  }

  @override
  Future<void> insertRecord(Map<String, Object?> values) async {
    await _database
        ?.transaction(
          (txn) => txn.insert(
            cardsTable,
            values,
            conflictAlgorithm: ConflictAlgorithm.replace,
          ),
        )
        .then((value) => log("$value Insert Successfully"))
        .catchError(
          (error) => log("$error", name: "Error when insert new record"),
        );
  }

  @override
  Future<void> updateRecord(int id, Map<String, Object?> values) async {
    await _database
        ?.update(
          cardsTable,
          values,
          where: "$colId = ?",
          whereArgs: [id],
        )
        .then((value) => log("$value Update Successfully"))
        .catchError((error) => log("$error", name: "Error when update record"));
  }

  @override
  Future<void> deleteRecords() async {
    await _database
        ?.delete(cardsTable)
        .then((_) => log("Delete All records Successfully"))
        .catchError(
          (error) => log("$error", name: "Error when delete all records"),
        );
  }

  @override
  Future<void> deleteRecordById(int id) async {
    await _database
        ?.delete(
          cardsTable,
          where: "$colId = ?",
          whereArgs: [id],
        )
        .then((value) => log("$value Delete Successfully"))
        .catchError((error) => log("$error", name: "Error when delete record"));
  }
}
