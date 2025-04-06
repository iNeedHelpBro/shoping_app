import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/pages/home_page.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/service/navigator.dart';
import 'package:shopping_app/themes/themeProvider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navi,
      theme: Provider.of<ThemeProvider>(context).mythemedata,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
