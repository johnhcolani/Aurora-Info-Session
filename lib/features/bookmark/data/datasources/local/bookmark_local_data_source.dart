import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/bookmark_model.dart';

class BookmarkLocalDataSource {
  BookmarkLocalDataSource();

  static const _databaseName = 'aurora_bookmarks.db';
  static const _databaseVersion = 1;
  static const _tableBookmarks = 'bookmarks';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(docsDir.path, _databaseName);

    return openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableBookmarks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            url TEXT NOT NULL UNIQUE,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<BookmarkModel>> getBookmarks() async {
    final db = await database;
    final result = await db.query(
      _tableBookmarks,
      orderBy: 'created_at DESC',
    );

    return result.map((row) => BookmarkModel.fromMap(row)).toList();
  }

  Future<void> insertBookmark(String url) async {
    final db = await database;
    await db.insert(
      _tableBookmarks,
      <String, dynamic>{
        'url': url,
        'created_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> deleteBookmark(String url) async {
    final db = await database;
    await db.delete(
      _tableBookmarks,
      where: 'url = ?',
      whereArgs: <Object?>[url],
    );
  }

  Future<bool> isBookmarked(String url) async {
    final db = await database;
    final result = await db.query(
      _tableBookmarks,
      columns: const ['id'],
      where: 'url = ?',
      whereArgs: <Object?>[url],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
