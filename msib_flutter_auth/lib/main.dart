import 'package:flutter/material.dart';
import 'package:msib_flutter_auth/auth_page.dart';
import 'package:msib_flutter_auth/controllers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: const MaterialApp(
          // ===============================
          // DISABLE LABLE DEBUG
          // ===============================
          debugShowCheckedModeBanner: false,
          // ===============================
          // MAIN PAGE
          // ===============================
          home: AuthPage()),
    );
  }
}
