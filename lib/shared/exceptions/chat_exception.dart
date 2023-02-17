class ChatException implements Exception {
  ChatException({
    required this.message,
  });

  final String message;
}
