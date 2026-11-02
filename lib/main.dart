import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(DapurMomApp());
}

class DapurMomApp extends StatelessWidget {
  const DapurMomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DAPUR MOM",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const LoginPage(),
    );
  }
}
