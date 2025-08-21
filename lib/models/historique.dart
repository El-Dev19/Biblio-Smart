import 'package:floor/floor.dart';

// Modèle Historique d'emprunt lié à un Book
@entity
class Historique {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int bookId;
  final String emprunteur;
  final String date;
  // final String retour;

  Historique({
    this.id,
    required this.bookId,
    required this.emprunteur,
    required this.date,
    // required this.retour,
  });
}
