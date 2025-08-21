import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/theme/theme.dart';
import 'package:provider/provider.dart';
import 'providers/book_provider.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookProvider()..initDB(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bibliosmart',
        theme: appTheme,
        home: const WelcomeScreen(),
      ),
    );
  }
}
