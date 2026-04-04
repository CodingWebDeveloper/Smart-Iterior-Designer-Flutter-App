import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/room_provider.dart';
import 'providers/catalog_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RoomProvider()),
        ChangeNotifierProvider(create: (context) => CatalogProvider()),
      ],
      child: MaterialApp(
        title: 'AI Interior Decorator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
