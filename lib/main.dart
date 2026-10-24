import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'task_store.dart';
import 'tasks_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(TodoMonthApp(store: TaskStore(prefs)));
}

class TodoMonthApp extends StatelessWidget {
  const TodoMonthApp({super.key, required this.store});

  final TaskStore store;

  static const seed = Color(0xFF0EA5E9);

  @override
  Widget build(BuildContext context) {
    ThemeData theme(Brightness brightness) => ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: seed,
            brightness: brightness,
            dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
          ),
        );

    return MaterialApp(
      title: 'TodoMonth',
      debugShowCheckedModeBanner: false,
      theme: theme(Brightness.light),
      darkTheme: theme(Brightness.dark),
      home: TasksPage(store: store),
    );
  }
}
