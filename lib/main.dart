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
          primaryColor: Color.fromARGB(255, 55, 177, 25),
          scaffoldBackgroundColor: Color.fromARGB(255, 44, 139, 20),
          appBarTheme: AppBarTheme(color: Color.fromARGB(255, 3, 148, 158)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.white),
              foregroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 24, 164, 219)),
              shape: WidgetStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
            ),
          ),
          textTheme: GoogleFonts.poppinsTextTheme(
            ThemeData.dark()
                .textTheme
                .apply(bodyColor: const Color.fromARGB(255, 0, 0, 0), displayColor: const Color.fromARGB(255, 255, 255, 255)),
          ),
          iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
          cardTheme: CardThemeData(
            color: Color.fromARGB(255, 3, 148, 158),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 4,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            fillColor: Color.fromARGB(255, 255, 252, 252),
            filled: true,
            labelStyle: TextStyle(color: const Color.fromARGB(255, 6, 173, 202)),
            hintStyle: TextStyle(color: const Color.fromARGB(255, 252, 248, 248)),
          ),
        ),
      ),
    ),
  );
}
