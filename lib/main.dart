import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:siksik_labuyo/view/screens/main_screen.dart';
import 'firebase/firebase_options.dart';

Future<void> main() async {
  // Start connection to Firebase
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
    var colorScheme = ColorScheme.fromSeed(seedColor: Colors.redAccent);

    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Siksik Labuyo',
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorScheme: colorScheme,
          appBarTheme: AppBarTheme(
            backgroundColor: colorScheme.primary,
            titleTextStyle: TextStyle(
              color: colorScheme.onPrimary,
              fontSize: 20,
            ),
            iconTheme: IconThemeData(
              color: colorScheme.onPrimary,
            ),
            actionsIconTheme: IconThemeData(
              color: colorScheme.onPrimary,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: colorScheme.primary,
            unselectedItemColor: colorScheme.onPrimary,
            selectedItemColor: colorScheme.inversePrimary,
            showSelectedLabels: true,
            showUnselectedLabels: false,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: colorScheme.inversePrimary,
            unselectedLabelColor: colorScheme.onPrimary,
          ),
          snackBarTheme: SnackBarThemeData(
            actionTextColor: colorScheme.primary,
            disabledActionTextColor: colorScheme.inversePrimary,
            elevation: 20,
            contentTextStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            showSelectedLabels: true,
            showUnselectedLabels: false,
          ),
        ),
        themeMode: ThemeMode.system,
        home: const MainScreen(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {}
