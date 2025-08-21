
import 'package:floor/floor.dart';
import 'package:myapp/models/book.dart';

/// DAO pour gérer CRUD des livres
@dao
abstract class BookDao {
  @Query('SELECT * FROM Book')
  Future<List<Book>> findAllBooks();

  @insert
  Future<void> insertBook(Book book);

  @update
  Future<void> updateBook(Book book);

  @delete
  Future<void> deleteBook(Book book);
}
