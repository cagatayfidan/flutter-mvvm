import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'package:idb_shim/idb.dart' as idb;
import 'package:idb_shim/idb_browser.dart' as idb;
import 'package:my_app/model/task.dart';

idb.IdbFactory? idbFactory;

class IndexedDB {
  static const String _storeName = "records";
  static const int _version = 1;
  late idb.Database _db;

  IndexedDB.named() {
    idbFactory = idb.getIdbFactory();
    open();
  }

  IndexedDB() {
    idbFactory = idb.getIdbFactory();
    open();
  }

  Future<void> open() async {
    return idbFactory!
        .open(_storeName, version: _version, onUpgradeNeeded: _onUpgradeNeeded)
        .then(_onDbOpened)
        .catchError(_onError);
  }

  void _onDbOpened(idb.Database db) {
    this._db = db;
  }

  void _onError(Object e) {
    window.console.log('An error occurred while opening the db: {$e}');
  }

  void _onUpgradeNeeded(idb.VersionChangeEvent e) {
    final db = (e.target as idb.OpenDBRequest).result;
    if (!db.objectStoreNames.contains(_storeName)) {
      db.createObjectStore(_storeName, keyPath: 'id', autoIncrement: true);
    }
  }

  Future<Object> writeToDatabase(Map<dynamic, dynamic> record) async {
    try {
      //TODO: find a proper way to open database
      await open();
      final transaction = _db.transaction(_storeName, 'readwrite');
      final store = transaction.objectStore(_storeName);
      store.add(record);
      await transaction.completed;
      return record;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<List<Task>> readFromDatabase() async {
    try {
      //TODO: find a proper way to open database
      await open();
      final transaction = await this._db.transaction(_storeName, 'readonly');
      final store = transaction.objectStore(_storeName);
      final snapshots = await store.getAll().then((value) => value);
      await transaction.completed;
      //TODO: find a proper way to convert json to object sucs as mapper
      return snapshots.map((e) => Task.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> deleteFromDatabase(int id) async {
    try {
      await open();
      final transaction = _db.transaction(_storeName, 'readwrite');
      final store = transaction.objectStore(_storeName);
      store.delete(id);
      await transaction.completed;
    } catch (e) {
      print(e);
    }
  }
}
