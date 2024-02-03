import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_repository/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black
    ));
    
    return MaterialApp(
      title: 'GitHub Repository',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue[900]!),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black12,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        CommitsScreen.routeName: (context) => const CommitsScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
