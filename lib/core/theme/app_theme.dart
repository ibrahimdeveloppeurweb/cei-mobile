import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

// Enhanced CEI app colors
extension CEIColors on AppColors {
  // Brand colors
  static const Color ceiOrange = Color(0xFFD68B45);
  static const Color ceiDarkOrange = Color(0xFFCA7F35);
  static const Color ceiLightOrange = Color(0xFFE9C39E);

  // Light theme colors
  static const Color lightInputBackground = Colors.white;
  static const Color lightInputBorder = Color(0xFFE0E0E0);
  static const Color lightCardBackground = Colors.white;
  static const Color lightScaffoldBackground = Color(0xFFF8F9FA);
  static const Color lightTextPrimary = Color(0xFF303030);
  static const Color lightTextSecondary = Color(0xFF6D6D6D);

  // Dark theme colors
  static const Color darkInputBackground = Color(0xFF424242);    // Lighter gray for better contrast
  static const Color darkInputBorder = Color(0xFF555555);        // More visible border
  static const Color darkCardBackground = Color(0xFF333333);
  static const Color darkScaffoldBackground = Color(0xFF121212);
  static const Color darkTextPrimary = Color(0xFFF0F0F0);
  static const Color darkTextSecondary = Color(0xFFAAAAAA);

  // Shared colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);
}

class AppTheme {
  static final _fontFamily = GoogleFonts.poppins().fontFamily;

  // Shared border radius
  static final BorderRadius _borderRadius = BorderRadius.circular(12);
  static final RoundedRectangleBorder _roundedShape = RoundedRectangleBorder(
    borderRadius: _borderRadius,
  );

  // Shared button styles
  static ButtonStyle _primaryButtonStyle(Color primary, Color onPrimary) {
    return ElevatedButton.styleFrom(
      backgroundColor: primary,
      foregroundColor: onPrimary,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  // Light theme input decoration
  static InputDecorationTheme _lightInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: CEIColors.lightInputBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CEIColors.lightInputBorder, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CEIColors.lightInputBorder, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CEIColors.ceiOrange, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.error, width: 2),
      ),
      labelStyle: TextStyle(
        color: CEIColors.lightTextSecondary,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        fontFamily: _fontFamily,
      ),
      hintStyle: TextStyle(
        color: CEIColors.lightTextSecondary.withOpacity(0.7),
        fontSize: 14,
        fontFamily: _fontFamily,
      ),
      errorStyle: TextStyle(
        color: AppColors.error,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: _fontFamily,
      ),
      prefixIconColor: CEIColors.ceiOrange,
      suffixIconColor: CEIColors.ceiOrange,
      isDense: false,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }

  // Dark theme input decoration
  static InputDecorationTheme _darkInputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      fillColor: CEIColors.darkInputBackground,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CEIColors.darkInputBorder, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CEIColors.darkInputBorder, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: CEIColors.ceiOrange, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF6E6E), width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF6E6E), width: 2),
      ),
      labelStyle: const TextStyle(
        color: Colors.white70,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: const TextStyle(
        color: Colors.white38,
        fontSize: 14,
      ),
      errorStyle: const TextStyle(
        color: Color(0xFFFF8A80),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: CEIColors.ceiLightOrange,
      suffixIconColor: CEIColors.ceiLightOrange,
      isDense: false,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    );
  }

  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: CEIColors.ceiOrange,
      useMaterial3: true,
      fontFamily: _fontFamily,
      brightness: Brightness.light,

      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: CEIColors.ceiOrange,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        background: CEIColors.lightScaffoldBackground,
        onBackground: CEIColors.lightTextPrimary,
        surface: CEIColors.lightCardBackground,
        onSurface: CEIColors.lightTextPrimary,
      ),

      // Scaffold
      scaffoldBackgroundColor: CEIColors.lightScaffoldBackground,

      // AppBar
      appBarTheme: AppBarTheme(
        color: AppColors.secondary,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: _fontFamily,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: CEIColors.lightCardBackground,
        elevation: 2,
        shape: _roundedShape,
        shadowColor: Colors.black.withOpacity(0.1),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: Color(0xFFEAEAEA),
        thickness: 1,
        space: 20,
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _primaryButtonStyle(CEIColors.ceiOrange, Colors.white),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: CEIColors.ceiOrange,
          side: const BorderSide(color: CEIColors.ceiOrange, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: _fontFamily,
            letterSpacing: 0.5,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: CEIColors.ceiOrange,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: _fontFamily,
          ),
        ),
      ),

      // Input decoration
      inputDecorationTheme: _lightInputDecorationTheme(),

      // Checkbox
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected)
              ? CEIColors.ceiOrange
              : Colors.transparent;
        }),
        side: const BorderSide(color: CEIColors.ceiDarkOrange, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected)
              ? CEIColors.ceiOrange
              : Colors.white;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected)
              ? CEIColors.ceiOrange.withOpacity(0.4)
              : Colors.grey.withOpacity(0.3);
        }),
        trackOutlineColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected)
              ? Colors.transparent
              : Colors.grey.withOpacity(0.5);
        }),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade200,
        disabledColor: Colors.grey.shade300,
        selectedColor: CEIColors.ceiLightOrange,
        secondarySelectedColor: CEIColors.ceiOrange,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        labelStyle: const TextStyle(color: CEIColors.lightTextPrimary),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        brightness: Brightness.light,
        shape: _roundedShape,
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: CEIColors.lightTextPrimary,
          fontFamily: _fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: CEIColors.lightTextPrimary,
          fontFamily: _fontFamily,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: CEIColors.lightTextPrimary,
          fontFamily: _fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: CEIColors.lightTextPrimary,
          fontFamily: _fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: CEIColors.lightTextPrimary,
          fontFamily: _fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: CEIColors.lightTextPrimary,
          fontFamily: _fontFamily,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: CEIColors.lightTextPrimary,
          fontFamily: _fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: CEIColors.lightTextSecondary,
          fontFamily: _fontFamily,
        ),
      ),

      // Bottom sheet theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: CEIColors.lightCardBackground,
        modalBackgroundColor: CEIColors.lightCardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: CEIColors.ceiOrange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Progress indicator theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: CEIColors.ceiOrange,
        circularTrackColor: Colors.grey[200]!,
      ),

      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: CEIColors.ceiOrange,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: CEIColors.ceiOrange,
      useMaterial3: true,
      fontFamily: _fontFamily,
      brightness: Brightness.dark,

      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: CEIColors.ceiOrange,
        onPrimary: Colors.white,
        secondary: Color(0xFF80DEEA), // Lighter blue for dark theme
        onSecondary: Colors.black,
        error: Color(0xFFEF6C6C), // Lighter red for dark theme
        onError: Colors.white,
        background: CEIColors.darkScaffoldBackground,
        onBackground: CEIColors.darkTextPrimary,
        surface: CEIColors.darkCardBackground,
        onSurface: CEIColors.darkTextPrimary,
      ),

      // Scaffold
      scaffoldBackgroundColor: CEIColors.darkScaffoldBackground,

      // AppBar
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: _fontFamily,
        ),
      ),

      // Card
      cardTheme: CardThemeData(
        color: CEIColors.darkCardBackground,
        elevation: 3,
        shape: _roundedShape,
        shadowColor: Colors.black.withOpacity(0.3),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: Color(0xFF414141),
        thickness: 1,
        space: 20,
      ),

      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _primaryButtonStyle(CEIColors.ceiOrange, Colors.white),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: CEIColors.ceiLightOrange,
          side: const BorderSide(color: CEIColors.ceiLightOrange, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: _fontFamily,
            letterSpacing: 0.5,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: CEIColors.ceiLightOrange,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: _fontFamily,
          ),
        ),
      ),

      // Input decoration - Using the specialized dark theme
      inputDecorationTheme: _darkInputDecorationTheme(),

      // Checkbox
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected)
              ? CEIColors.ceiOrange
              : Colors.transparent;
        }),
        side: const BorderSide(color: CEIColors.ceiLightOrange, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected)
              ? CEIColors.ceiOrange
              : Colors.grey;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          return states.contains(MaterialState.selected)
              ? CEIColors.ceiOrange.withOpacity(0.5)
              : Colors.grey.withOpacity(0.3);
        }),
        trackOutlineColor: MaterialStateProperty.resolveWith((states) {
          return Colors.transparent;
        }),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: const Color(0xFF3A3A3A),
        disabledColor: const Color(0xFF2A2A2A),
        selectedColor: CEIColors.ceiOrange.withOpacity(0.3),
        secondarySelectedColor: CEIColors.ceiOrange,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        labelStyle: const TextStyle(color: CEIColors.darkTextPrimary),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        brightness: Brightness.dark,
        shape: _roundedShape,
      ),

      // Text theme
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: CEIColors.darkTextPrimary,
          fontFamily: _fontFamily,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: CEIColors.darkTextPrimary,
          fontFamily: _fontFamily,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: CEIColors.darkTextPrimary,
          fontFamily: _fontFamily,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: CEIColors.darkTextPrimary,
          fontFamily: _fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.white, // Explicit white for better visibility in dark text fields
          fontFamily: _fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.white, // Explicit white for better visibility in dark text fields
          fontFamily: _fontFamily,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: CEIColors.darkTextPrimary,
          fontFamily: _fontFamily,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: CEIColors.darkTextSecondary,
          fontFamily: _fontFamily,
        ),
      ),

      // Bottom sheet theme
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: CEIColors.darkCardBackground,
        modalBackgroundColor: CEIColors.darkCardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        clipBehavior: Clip.antiAlias,
      ),

      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF1E1E1E),
        selectedItemColor: CEIColors.ceiOrange,
        unselectedItemColor: Color(0xFFA0A0A0),
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: CEIColors.ceiOrange,
        circularTrackColor: Color(0xFF3A3A3A),
      ),

      // Floating action button theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: CEIColors.ceiOrange,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Dialog theme
      dialogTheme: DialogThemeData(
        backgroundColor: const Color(0xFF2A2A2A),
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}