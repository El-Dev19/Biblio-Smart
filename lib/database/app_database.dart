import 'dart:async';
import 'package:floor/floor.dart';
import 'package:myapp/database/emprunt_histo_dao.dart';
import 'package:myapp/models/historique.dart';
// import 'package:myapp/models/hitorique.dart';
import '../models/book.dart';
import 'book_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite; // Pour Database, DatabaseExecutor

/// AppDatabase qui connecte tous les DAOs
part 'app_database.g.dart'; // Fichier généré

@Database(version: 1, entities: [Book, Historique])
abstract class AppDatabase extends FloorDatabase {
  BookDao get bookDao;
  EmpruntHistoDao get empruntHistoDao;
}
