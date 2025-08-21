import 'package:floor/floor.dart';

@entity
class Book {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String auteur;
  final int anPublication;
  final String genre;

  Book({
    this.id,
    required this.title,
    required this.auteur,
    required this.anPublication,
    required this.genre,
  });
}
