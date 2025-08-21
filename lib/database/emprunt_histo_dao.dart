import 'package:floor/floor.dart';
import 'package:myapp/models/historique.dart';
// import 'package:myapp/models/hitorique.dart';

/// DAO pour gérer CRUD de l'historique d'emprunt
@dao
abstract class EmpruntHistoDao {
  @Query('SELECT * FROM Historique WHERE bookId = :bookId')
  Future<List<Historique>> findHistoryForBook(int bookId);

  @insert
  Future<void> insertHistorique(Historique history);

  @delete
  Future<void> deleteHistorique(Historique history);
}
