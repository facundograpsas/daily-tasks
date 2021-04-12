
import 'package:daily_tajsks/task/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TasksDatabase{

  TasksDatabase._privateConstructor();
  static final instance = TasksDatabase._privateConstructor();

  static final table = "task";
  static final id = "id";

  static Database? _database;

  Future<Database?> get database async {
    if(_database!=null){
      return _database;
    }
    else{
      _database = await _initDb();
      return _database;
    }
  }

  _initDb() async {
    String path = join(await getDatabasesPath(), "tasksdb");
    return await openDatabase(path,
        version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE "task" (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            text STRING NOT NULL
          )
          ''');
  }

  Future<int> insert(Task task) async {
    Database db = (await instance.database)!;
    var res = await db.insert(table, task.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = (await instance.database)!;
    var res = await db.query(table, orderBy: "$id DESC");
    return res;
  }

  Future<void> delete(int id) async {
    Database db = (await instance.database)!;
    // return await db.delete(table, where: '$id = ?', whereArgs: [id]);
    await db.rawQuery('DELETE FROM $table WHERE id=?', [id]);

  }

  Future<void> clearTable() async {
    Database db = (await instance.database)!;
    await db.rawQuery("DELETE FROM $table");
  }

  Future<Map<String, dynamic>> get(int id) async {
    Database db = (await instance.database)!;
    var taskMap =  await db.rawQuery('SELECT * FROM $table WHERE id=?', [id]);
    return taskMap.first;
  }

}