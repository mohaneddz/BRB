import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the global custom theme for a futuristic, simple, modern, and secure app.
/// This theme uses a dark background, a primary red color, and the Kumar One font.
///
/// Renamed from `appTheme` to `primaryTheme` as requested.
final ThemeData primaryTheme = ThemeData(
  brightness: Brightness.dark,

  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: AppColors.enabledText,
    secondary: AppColors.primary,
    onSecondary: AppColors.enabledText,
    error: AppColors.primary,
    onError: AppColors.enabledText,
    surface: AppColors.darkBg,
    onSurface: AppColors.enabledText,
  ),

  scaffoldBackgroundColor: AppColors.darkBg,

  textTheme: TextTheme(
    displayLarge: GoogleFonts.kumarOne(fontSize: 57, fontWeight: FontWeight.bold, color: AppColors.enabledText),
    displayMedium: GoogleFonts.kumarOne(fontSize: 45, fontWeight: FontWeight.bold, color: AppColors.enabledText),
    displaySmall: GoogleFonts.kumarOne(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.enabledText),
    headlineLarge: GoogleFonts.kumarOne(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.enabledText),
    headlineMedium: GoogleFonts.kumarOne(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.enabledText),
    headlineSmall: GoogleFonts.kumarOne(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.enabledText),
    titleLarge: GoogleFonts.kumarOne(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.enabledText),
    titleMedium: GoogleFonts.kumarOne(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.enabledText),
    titleSmall: GoogleFonts.kumarOne(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.enabledText),
    bodyLarge: GoogleFonts.kumarOne(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.disabledText),
    bodyMedium: GoogleFonts.kumarOne(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.disabledText),
    bodySmall: GoogleFonts.kumarOne(fontSize: 12, fontWeight: FontWeight.normal, color: AppColors.disabledText),
    labelLarge: GoogleFonts.kumarOne(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.enabledText),
    labelMedium: GoogleFonts.kumarOne(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.enabledText),
    labelSmall: GoogleFonts.kumarOne(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.enabledText),
  ),

  appBarTheme: const AppBarTheme(
    surfaceTintColor: AppColors.darkBg,
    backgroundColor: AppColors.darkBgLight,
    foregroundColor: AppColors.enabledText,
    elevation: 0,
    centerTitle: true,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppColors.enabledText,
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: GoogleFonts.kumarOne(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColors.primary, textStyle: GoogleFonts.kumarOne(fontSize: 16)),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primary,
      side: const BorderSide(color: AppColors.primary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: GoogleFonts.kumarOne(fontSize: 16),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkBg.withValues(alpha: 0.8), // Slightly transparent dark background
    labelStyle: GoogleFonts.kumarOne(color: AppColors.disabledText),
    hintStyle: GoogleFonts.kumarOne(color: AppColors.disabledText),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.disabledText, width: 1),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: AppColors.primary, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),

  cardTheme: CardThemeData(
    color: AppColors.darkBg,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.all(8),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.darkBg,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.disabledText,
    selectedIconTheme: IconThemeData(
      color: AppColors.primary,
      size: 24, // Smaller icon size
    ),
    unselectedIconTheme: IconThemeData(
      color: AppColors.disabledText,
      size: 24, // Smaller icon size
    ),
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10, // Smaller text
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 10, // Smaller text3
    ),
    type: BottomNavigationBarType.fixed,
  ),

  switchTheme: SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.disabledText;
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary.withValues(alpha: 0.5);
      }
      return AppColors.darkBg;
    }),
  ),

  sliderTheme: SliderThemeData(
    activeTrackColor: AppColors.primary,
    inactiveTrackColor: AppColors.disabledText,
    thumbColor: AppColors.primary,
    overlayColor: AppColors.primary.withValues(alpha: 0.5),
    valueIndicatorColor: AppColors.primary,
    valueIndicatorTextStyle: GoogleFonts.kumarOne(color: AppColors.enabledText),
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.darkBg,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    titleTextStyle: GoogleFonts.kumarOne(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.enabledText),
    contentTextStyle: GoogleFonts.kumarOne(fontSize: 16, color: AppColors.disabledText),
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.disabledText;
    }),
    checkColor: WidgetStateProperty.all(AppColors.enabledText),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),

  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.primary;
      }
      return AppColors.disabledText;
    }),
  ),

  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(color: AppColors.darkBg.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)),
    textStyle: GoogleFonts.kumarOne(color: AppColors.enabledText, fontSize: 12),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.darkBg,
    contentTextStyle: GoogleFonts.kumarOne(color: AppColors.enabledText),
    actionTextColor: AppColors.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    behavior: SnackBarBehavior.floating,
  ),

  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.primary,
    unselectedLabelColor: AppColors.disabledText,
    indicator: const UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.primary, width: 3.0)),
    labelStyle: GoogleFonts.kumarOne(fontWeight: FontWeight.bold),
    unselectedLabelStyle: GoogleFonts.kumarOne(),
  ),

  dividerTheme: const DividerThemeData(color: AppColors.disabledText, thickness: 1, space: 16),

  // iconTheme: const IconThemeData(color: AppColors.disabledText, size: 24),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.enabledText,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
  ),
);

/// Public class to hold all custom color definitions for better organization.
class AppColors {
  static const Color darkBg = Color(0xFF0A0A09); // Dark background for dark mode.
  static const Color darkBgLight = Color(0xFF181816); // Slightly lighter dark background for contrast.
  static const Color darkBgLightDropdown = Color.fromARGB(255, 18, 18, 18); // Slightly lighter dark background for contrast.
  static const Color lightBg = Color(0xFFFFFFFF); // Light background for light mode.
  static const Color primary = Color(0xFFF8231C); // Primary accent color.
  static const Color accent = Color.fromARGB(255, 245, 75, 69); // Primary accent color.
  static const Color foreground = Color(0xFF181816); // Foreground (text/icons on light bg).
  static const Color disabledText = Color(0xFF696969); // Disabled text color.
  static const Color enabledText = Color(0xFFFFFFFF); // Enabled/primary text color.
}
