import 'package:flutter/material.dart';
import 'package:the_wall/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_wall/theme/dark_theme.dart';
import 'package:the_wall/theme/light_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
