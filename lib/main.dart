import 'package:flutter/material.dart';
import 'package:grocery_app/const/theme_data.dart';
import 'package:grocery_app/providers/dart_theme_provider.dart';
import 'package:grocery_app/screens/bottom_bar.dart';
import 'package:grocery_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme = await themeChangeProvider.darkThemePrefs.getTheme();
  }
@override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // bool _isDark = true;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const BottomBarScreen(),
          );
        }
      ),
    );
  }
}