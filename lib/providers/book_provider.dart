import 'package:flutter/material.dart';
import '../models/book.dart';
import '../database/app_database.dart';

/// Provider pour gérer les livres via DAO Floor
class BookProvider with ChangeNotifier {
  late AppDatabase database;
  List<Book> _books = [];

  List<Book> get books => _books;
  Future <void> initDB() async {
    database = await $FloorAppDatabase
        .databaseBuilder('bibliosmart.db')
        .build();
    await loadBooks();
  }

  Future<void> loadBooks() async {
    _books = await database.bookDao.findAllBooks();
    notifyListeners();
  }

  Future <void> addBook(Book book) async {
    await database.bookDao.insertBook(book);
    await loadBooks();
  }

  Future <void> updateBook(Book book) async {
    await database.bookDao.updateBook(book);
    await loadBooks();
  }

  Future <void> deleteBook(Book book) async {
    await database.bookDao.deleteBook(book);
    await loadBooks();
  }
}
