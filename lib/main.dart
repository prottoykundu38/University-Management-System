import 'package:flutter/material.dart';
import 'package:univarsity_management_system/Screens/login_page.dart';
import 'package:univarsity_management_system/Screens/signUp_screen.dart';
import 'package:univarsity_management_system/Screens/welcome_page.dart';
import 'package:univarsity_management_system/widgets/bottom_nav_bar_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Event Management',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        // primarySwatch: Colors.blue, // change this to your preferred color
        cardColor: Color(0xFFD1A170), // default card color
        splashColor:
            Color(0xFFD1A170), // disable ripple purple splash if needed
        highlightColor: Color(0xFFD1A170), // also this

        scaffoldBackgroundColor: Color.fromARGB(
          255,
          255,
          255,
          255,
        ), // Background color for all pages (swapped)
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Default body text color (swapped)
          bodyMedium: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Default body text color (swapped)
          bodySmall: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Default body text color (swapped)
          titleLarge: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Title text color (swapped)
          titleMedium: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Title text color (swapped)
          titleSmall: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Title text color (swapped)
          displayLarge: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Display text color (swapped)
          displayMedium: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Display text color (swapped)
          displaySmall: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Display text color (swapped)
          headlineLarge: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Headline text color (swapped)
          headlineMedium: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Headline text color (swapped)
          headlineSmall: TextStyle(
            color: Color(0xFF4A2A11),
          ), // Headline text color (swapped)
        ),
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => BottomNavBar(),
      },
    );
  }
}
