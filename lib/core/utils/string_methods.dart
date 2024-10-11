class StringMethods {
  static String generateRandomString() {
    final int secondsSinceEpoch = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return secondsSinceEpoch.toString();
  }
}
