import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import 'package:myapp/database/emprunt_histo_dao.dart';
import 'package:myapp/models/book.dart';
import 'package:myapp/models/historique.dart';
import 'package:myapp/providers/book_provider.dart';
import 'package:myapp/screens/add_editbook_screen.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;
  const BookDetailScreen({super.key, required this.book});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  List<Historique> _history = [];

  final _histoController = TextEditingController();

  Future <void> _loadHistory() async{
    final db = Provider.of<BookProvider>(context, listen: false).database;
    _history = await db.empruntHistoDao.findHistoryForBook(widget.book.id!);
    setState(() {});
  }

  Future <void> _addHistory () async {
    final db = Provider.of(context)<BookProvider> (context, listen: false).database;

    final history = Historique(
      bookId: widget.book.id!,
      emprunteur: _histoController.text.trim(),
      date: DateTime.now().toIso8601String(),
    );

    await db.empruntHistoDao.insertHistorique(history);
    _histoController.clear();
    _loadHistory();


  }
  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditBookScreen(book: widget.book),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await bookProvider.deleteBook(widget.book);
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Auteur : ${widget.book.auteur}', style: const TextStyle(fontSize: 18)),
            Text('Année : ${widget.book.anPublication}', style: const TextStyle(fontSize: 18)),
            Text('Genre : ${widget.book.genre}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('Historique des emprunts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _histoController,
              decoration: const InputDecoration(
                labelText: 'Nom de l\'emprunteur',
                suffixIcon: Icon(Icons.person),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_histoController.text.trim().isNotEmpty) {
                  _addHistory();
                }
              },
              child: const Text('Ajouter emprunt'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (_, index) {
                  final h = _history[index];
                  return ListTile(
                    title: Text(h.emprunteur),
                    subtitle: Text(h.date.substring(0, 10)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
