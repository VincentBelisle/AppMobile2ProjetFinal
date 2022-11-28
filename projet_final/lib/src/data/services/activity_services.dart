import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../entities/activity_entity.dart';

class ActivityService {
  Future<Database>? database;
  static const String databasePath = 'wack-a-mole.db';
  static const String tableActivityName = 'Activity';
  ActivityService() {
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<Database> getDatabaseInstance() async {
    database ??= openDatabase(
      join(await getDatabasesPath(), databasePath),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE IF NOT EXISTS $tableActivityName(id INTEGER PRIMARY KEY,nom TEXT, description TEXT, date TEXT)",
        );
      },
      version: 2,
    );

    return database!;
  }

  Future<void> insertActivity(ActivityEntity activity) async {
    // Get a reference to the database.
    final Database db = await getDatabaseInstance();

    await db.insert(
      tableActivityName,
      activity.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ActivityEntity>> activities() async {
    final Database db = await getDatabaseInstance();

    final List<Map<String, dynamic>> maps = await db.query(tableActivityName);

    return List.generate(maps.length, (i) {
      return ActivityEntity.FromMap(maps[i]);
    });
  }

  Future<void> deleteActivity(int id) async {
    final db = await getDatabaseInstance();

    await db.delete(
      tableActivityName,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> updateActivity(ActivityEntity activity) async {
    final db = await getDatabaseInstance();

    await db.update(
      tableActivityName,
      activity.toMap(),
      where: "id = ?",
      whereArgs: [activity.id],
    );
  }
}
