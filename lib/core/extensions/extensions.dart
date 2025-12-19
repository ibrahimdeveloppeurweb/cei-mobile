extension StringWhitespaceExtension on String {
  /// Removes all whitespace characters from the string
  String removeAllWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Removes all whitespace and normalizes the string for voter ID format
  String normalizeVoterId() {
    // First remove all whitespace
    String normalized = removeAllWhitespace();

    // Ensure uppercase for any letters
    normalized = normalized.toUpperCase();

    return normalized;
  }
}