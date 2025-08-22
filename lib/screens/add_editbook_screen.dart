import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';

class AddEditBookScreen extends StatefulWidget {
  final Book? book;

  const AddEditBookScreen({super.key, this.book});

  @override
  State<AddEditBookScreen> createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _auteurController;
  late TextEditingController _anneeController;
  late TextEditingController _genreController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _auteurController = TextEditingController(text: widget.book?.auteur ?? '');
    _anneeController = TextEditingController(
      text: widget.book?.anPublication.toString() ?? '',
    );
    _genreController = TextEditingController(text: widget.book?.genre ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _auteurController.dispose();
    _anneeController.dispose();
    _genreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book == null ? 'Ajouter Livre' : 'Modifier Livre'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (v) => v!.isEmpty ? 'Entrez un titre' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _auteurController,
                decoration: const InputDecoration(labelText: 'Auteur'),
                validator: (v) => v!.isEmpty ? 'Entrez un auteur' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _anneeController,
                decoration: const InputDecoration(labelText: 'Année'),
                keyboardType: TextInputType.number,
                validator: (v) => v!.isEmpty ? 'Entrez une année' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _genreController,
                decoration: const InputDecoration(labelText: 'Genre'),
                validator: (v) => v!.isEmpty ? 'Entrez un genre' : null,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final newBook = Book(
                      id: widget.book?.id,
                      title: _titleController.text.trim(),
                      auteur: _auteurController.text.trim(),
                      anPublication: int.parse(_anneeController.text.trim()),
                      genre: _genreController.text.trim(),
                    );

                    if (widget.book == null) {
                      await bookProvider.addBook(newBook);
                    } else {
                      await bookProvider.updateBook(newBook);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.book == null ? 'Ajouter' : 'Mettre à jour'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
