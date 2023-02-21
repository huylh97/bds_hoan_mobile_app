class UtilString {
  static String? capitalize(String? text) {
    if (text == null || text.isEmpty) return null;
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }

  static String? toCommaString(String text) {
    final chars = text.split('');

    String newString = '';
    for (int i = chars.length - 1; i >= 0; i--) {
      if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
        newString = "," + newString;
      }
      newString = chars[i] + newString;
    }
    return newString;
  }

  static String? uppercaseFirstLetter(String? text) {
    if (text == null || text.isEmpty) return null;
    return "${text[0].toUpperCase()}${text.substring(1)}";
  }
}
