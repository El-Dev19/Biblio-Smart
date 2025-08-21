import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
// import 'add_edit_book_screen.dart';
// import 'book_detail_screen.dart';

/// Écran Liste des Livres — respecte ton design, liste + bouton ajout
class BooksListScreen extends StatefulWidget {
  const BooksListScreen({super.key});

  @override
  State<BooksListScreen> createState() => _BooksListScreenState();
}

class _BooksListScreenState extends State<BooksListScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    final books = _searchController.text.isEmpty
        ? bookProvider.books
        : bookProvider.books
            .where((b) => b.title
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();

    return Scaffold(
      appBar: AppBar(
        leading: 
            Padding(
              padding: EdgeInsets.only(left: 3, top: 20),
              child: Text("Books",
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold),
                    textAlign: TextAlign.right),
        ),
        // title: const Text('Mes Livres'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => const AddEditBookScreen()),
              // );
            },
          )
        ],
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Rechercher...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (_, index) {
                final book = books[index];
                return ListTile(
                  title: Text(book.title),
                  subtitle: Text(book.auteur),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => bookProvider.deleteBook(book),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) => BookDetailScreen(book: book),
                    //   ),
                    // );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
