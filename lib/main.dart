import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData(
          primaryColor: Color(0xFF8B2722),
          scaffoldBackgroundColor: Color(0xFF8B2722),
          appBarTheme: AppBarTheme(color: Color(0xFF000000)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(Colors.black),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
            ),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(
            ThemeData.dark()
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          cardTheme: CardThemeData(
            color: Color(0xFF000000),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            fillColor: Color.fromARGB(255, 2, 2, 2),
            filled: true,
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}
