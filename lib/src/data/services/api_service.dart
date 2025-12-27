import 'dart:math';

import 'package:dio/dio.dart';

class ApiService {
  static final Random _random = Random();
  static final Dio _dio = Dio(
    BaseOptions(connectTimeout: const Duration(seconds: 8), receiveTimeout: const Duration(seconds: 8)),
  );

  static Future<String> fetchRandomMessage() async {
    final apiChoice = _random.nextInt(4);
    try {
      switch (apiChoice) {
        case 0:
          return await _fetchQuote();
        case 1:
          return await _fetchComment();
        case 2:
          return await _fetchActivity();
        default:
          return await _fetchPlaceholder();
      }
    } catch (e) {
      return _fallbackMessages[_random.nextInt(_fallbackMessages.length)];
    }
  }

  static Future<String> _fetchQuote() async {
    final response = await _dio.get('https://api.quotable.io/random');
    return response.data['content'] ?? _fallback();
  }

  static Future<String> _fetchComment() async {
    final response = await _dio.get('https://dummyjson.com/comments/${_random.nextInt(100) + 1}');
    return response.data['body'] ?? _fallback();
  }

  static Future<String> _fetchActivity() async {
    final response = await _dio.get('https://www.boredapi.com/api/activity');
    return 'How about: ${response.data['activity']}';
  }

  static Future<String> _fetchPlaceholder() async {
    final response = await _dio.get('https://jsonplaceholder.typicode.com/comments/${_random.nextInt(100) + 1}');
    return response.data['body'] ?? _fallback();
  }

  static String _fallback() => _fallbackMessages[_random.nextInt(_fallbackMessages.length)];

  static final List<String> _fallbackMessages = [
    'Hey! How are you?',
    'That\'s interesting!',
    'Tell me more.',
    'I see what you mean.',
    'Sounds great!',
    'What do you think?',
    'I completely agree!',
    'Let\'s discuss this.',
    'That makes sense!',
  ];

  static Future<String> fetchWordMeaning(String word) async {
    try {
      final response = await _dio.get('https://api.dictionaryapi.dev/api/v2/entries/en/$word');
      final data = response.data;
      if (data is List && data.isNotEmpty) {
        final meanings = data[0]['meanings'];
        if (meanings != null && meanings.isNotEmpty) {
          final definitions = meanings[0]['definitions'];
          if (definitions != null && definitions.isNotEmpty) {
            return definitions[0]['definition'] ?? 'No definition found';
          }
        }
      }
      return 'No definition for "$word"';
    } catch (e) {
      return 'Unable to fetch meaning';
    }
  }
}
