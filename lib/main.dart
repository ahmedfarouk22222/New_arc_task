import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = getIt<Dio>();
    assert(dio.options.baseUrl.isNotEmpty);
    return const MaterialApp(
      home: Scaffold(
        body: SizedBox.shrink(),
      ),
    );
  }
}
