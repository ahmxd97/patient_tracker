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
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          useMaterial3: true, // Enable Material 3 for modern design

          // Primary Blue for main brand color
          primaryColor: Color(0xFF0072CE),

          // Softer background for homey feel
          scaffoldBackgroundColor: Color(0xFFF8FAFB),

          // Modern AppBar with subtle elevation
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFFFFFFFF),
            foregroundColor: Color(0xFF231F20),
            elevation: 0,
            surfaceTintColor: Color(0xFF41B6E6).withOpacity(0.03),
            centerTitle: false,
            titleTextStyle: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF231F20),
            ),
            iconTheme: IconThemeData(color: Color(0xFF231F20)),
          ),

          // Healing Green buttons with smooth animations
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered)) {
                  return Color(0xFF00A843); // Lighter green on hover
                }
                return Color(0xFF009639);
              }),
              foregroundColor: WidgetStateProperty.all(Color(0xFFFFFFFF)),
              elevation: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.pressed)) return 1;
                if (states.contains(WidgetState.hovered)) return 6;
                return 2;
              }),
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              animationDuration: Duration(milliseconds: 200),
            ),
          ),

          // Warm, readable text theme
          textTheme: GoogleFonts.poppinsTextTheme(
            ThemeData.light().textTheme.apply(
                  bodyColor: Color(0xFF231F20),
                  displayColor: Color(0xFF231F20),
                ),
          ).copyWith(
            headlineLarge: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Color(0xFF231F20),
              letterSpacing: -0.5,
            ),
            headlineMedium: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF231F20),
            ),
            bodyLarge: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF231F20),
              height: 1.6,
            ),
          ),

          iconTheme: IconThemeData(color: Color(0xFF0072CE)),

          // Modern card design with subtle shadows
          cardTheme: CardThemeData(
            color: Color(0xFFFFFFFF),
            surfaceTintColor: Color(0xFF41B6E6).withOpacity(0.05),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 2,
            shadowColor: Color(0xFF0072CE).withOpacity(0.08),
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),

          // Softer input fields
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xFFE0E5EA), width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xFFE0E5EA), width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Color(0xFF0072CE), width: 2),
            ),
            fillColor: Color(0xFFFFFFFF),
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            labelStyle: TextStyle(
              color: Color(0xFF0072CE),
              fontWeight: FontWeight.w500,
            ),
            hintStyle: TextStyle(
              color: Color(0xFF231F20).withOpacity(0.4),
              fontWeight: FontWeight.w400,
            ),
          ),

          // Modern color scheme
          colorScheme: ColorScheme.light(
            primary: Color(0xFF0072CE),
            secondary: Color(0xFF009639),
            tertiary: Color(0xFF41B6E6),
            surface: Color(0xFFFFFFFF),
            background: Color(0xFFF8FAFB),
            error: Color(0xFFDC3545),
            onPrimary: Color(0xFFFFFFFF),
            onSecondary: Color(0xFFFFFFFF),
            onSurface: Color(0xFF231F20),
            onBackground: Color(0xFF231F20),
            surfaceVariant: Color(0xFFF0F4F8),
          ),

          // Smooth page transitions
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          ),

          // Splash and ripple effects
          splashFactory: InkRipple.splashFactory,
          splashColor: Color(0xFF0072CE).withOpacity(0.1),
          highlightColor: Color(0xFF41B6E6).withOpacity(0.05),
        ),
      ),
    ),
  );
}
