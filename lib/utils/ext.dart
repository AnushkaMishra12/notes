import 'dart:ui';

extension ColorExt on String? {
  Color toColor() {
    if (this == null) {
      return const Color(0xFFFFFFFF);
    }
    final hexCode = this!.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }
}

extension HexColor on Color {
  /// Converts a Color object to a hex string.
  String toHex({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        // '${alpha.toRadixString(16).padLeft(2, '0')}'
        '${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';
  }
}
