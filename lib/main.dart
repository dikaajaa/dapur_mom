import 'package:flutter/material.dart';

import 'pages/login_page.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DapurMomApp());
}

class DapurMomApp extends StatelessWidget {
  const DapurMomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DapurMOM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginPage(),
    );
  }
}
