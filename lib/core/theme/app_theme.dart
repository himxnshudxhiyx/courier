import 'package:flutter/material.dart';

const kMonoFont = 'monospace';
const kMonoFallback = ['Menlo', 'Roboto Mono', 'Courier New'];

TextStyle monoStyle(BuildContext context, {double fontSize = 13, Color? color, FontWeight? fontWeight}) => TextStyle(
      fontFamily: kMonoFont,
      fontFamilyFallback: kMonoFallback,
      fontSize: fontSize,
      height: 1.45,
      color: color ?? Theme.of(context).colorScheme.onSurface,
      fontWeight: fontWeight,
    );

abstract final class AppColors {
  static const accent = Color(0xFFE5A93A);
  static const accentOnLight = Color(0xFF8F5C00);
}

Color methodColor(String method, Brightness brightness) {
  final dark = brightness == Brightness.dark;
  return switch (method.toUpperCase()) {
    'GET' => dark ? const Color(0xFF4CC38A) : const Color(0xFF1A7F4B),
    'POST' => dark ? const Color(0xFFE5A93A) : const Color(0xFF8F5C00),
    'PUT' => dark ? const Color(0xFF5EA6FF) : const Color(0xFF1F5FBF),
    'PATCH' => dark ? const Color(0xFFC08CFF) : const Color(0xFF7A3FC4),
    'DELETE' => dark ? const Color(0xFFFF6B6B) : const Color(0xFFC62828),
    _ => dark ? const Color(0xFF9DA5B0) : const Color(0xFF5F6770),
  };
}

Color statusColor(int code, Brightness brightness) {
  final dark = brightness == Brightness.dark;
  if (code >= 200 && code < 300) return dark ? const Color(0xFF4CC38A) : const Color(0xFF1A7F4B);
  if (code >= 300 && code < 400) return dark ? const Color(0xFF5EA6FF) : const Color(0xFF1F5FBF);
  if (code >= 400 && code < 500) return dark ? const Color(0xFFF0A04B) : const Color(0xFFB45309);
  return dark ? const Color(0xFFFF6B6B) : const Color(0xFFC62828);
}

class CodePalette {
  const CodePalette({
    required this.key,
    required this.string,
    required this.number,
    required this.literal,
    required this.punctuation,
    required this.match,
  });

  final Color key;
  final Color string;
  final Color number;
  final Color literal;
  final Color punctuation;
  final Color match;

  static CodePalette of(Brightness brightness) => brightness == Brightness.dark
      ? const CodePalette(
          key: Color(0xFF9CDCFE),
          string: Color(0xFFE5B97A),
          number: Color(0xFFB5CEA8),
          literal: Color(0xFFC586C0),
          punctuation: Color(0xFF8A8A8A),
          match: Color(0x66E5A93A),
        )
      : const CodePalette(
          key: Color(0xFF0451A5),
          string: Color(0xFFA31515),
          number: Color(0xFF098658),
          literal: Color(0xFF8B2FC9),
          punctuation: Color(0xFF7A7A7A),
          match: Color(0x55E5A93A),
        );
}

ThemeData buildAppTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final base = ColorScheme.fromSeed(seedColor: AppColors.accent, brightness: brightness);
  final scheme = dark
      ? base.copyWith(
          primary: AppColors.accent,
          onPrimary: const Color(0xFF1F1500),
          surface: const Color(0xFF171717),
          onSurface: const Color(0xFFE8E8E8),
          onSurfaceVariant: const Color(0xFFA3A3A3),
          surfaceContainerLowest: const Color(0xFF111111),
          surfaceContainerLow: const Color(0xFF1D1D1D),
          surfaceContainer: const Color(0xFF232323),
          surfaceContainerHigh: const Color(0xFF2A2A2A),
          surfaceContainerHighest: const Color(0xFF333333),
          outline: const Color(0xFF4D4D4D),
          outlineVariant: const Color(0xFF2E2E2E),
          secondaryContainer: const Color(0xFF3A2E14),
          onSecondaryContainer: AppColors.accent,
        )
      : base.copyWith(
          primary: AppColors.accentOnLight,
          onPrimary: Colors.white,
          surface: const Color(0xFFFBFAF7),
          onSurface: const Color(0xFF1C1B19),
          onSurfaceVariant: const Color(0xFF66625B),
          surfaceContainerLowest: Colors.white,
          surfaceContainerLow: const Color(0xFFF4F2EE),
          surfaceContainer: const Color(0xFFEEECE7),
          surfaceContainerHigh: const Color(0xFFE7E5E0),
          surfaceContainerHighest: const Color(0xFFE0DED8),
          outlineVariant: const Color(0xFFE0DDD6),
          secondaryContainer: const Color(0xFFF6E3BD),
          onSecondaryContainer: const Color(0xFF5C3B00),
        );

  final fieldBorder = OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none);

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.surface,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: scheme.onSurface),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: scheme.surfaceContainerLow,
      indicatorColor: scheme.secondaryContainer,
      height: 66,
      labelTextStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: scheme.surfaceContainer,
      hintStyle: TextStyle(color: scheme.onSurfaceVariant.withValues(alpha: 0.7)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      border: fieldBorder,
      enabledBorder: fieldBorder,
      focusedBorder: fieldBorder.copyWith(borderSide: BorderSide(color: scheme.primary, width: 1.2)),
    ),
    dividerTheme: DividerThemeData(color: scheme.outlineVariant, thickness: 1, space: 1),
    tabBarTheme: TabBarThemeData(
      labelColor: scheme.onSurface,
      unselectedLabelColor: scheme.onSurfaceVariant,
      indicatorColor: scheme.primary,
      dividerColor: scheme.outlineVariant,
      indicatorSize: TabBarIndicatorSize.label,
      tabAlignment: TabAlignment.start,
      labelPadding: const EdgeInsets.symmetric(horizontal: 14),
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
    chipTheme: ChipThemeData(
      side: BorderSide(color: scheme.outlineVariant),
      showCheckmark: false,
      selectedColor: scheme.secondaryContainer,
      labelStyle: TextStyle(fontSize: 13, color: scheme.onSurface),
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: scheme.surfaceContainerLow, showDragHandle: true),
    dialogTheme: DialogThemeData(backgroundColor: scheme.surfaceContainerLow),
    listTileTheme: ListTileThemeData(iconColor: scheme.onSurfaceVariant),
    expansionTileTheme: const ExpansionTileThemeData(shape: Border(), collapsedShape: Border()),
  );
}
