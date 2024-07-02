import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/blocs/bloc_exports.dart';
import 'package:tasks_app/screens/tabs_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TasksBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TabsScreen(),
      ),
    );
  }
}
