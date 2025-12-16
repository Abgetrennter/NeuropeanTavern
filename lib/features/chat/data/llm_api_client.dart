import 'package:dio/dio.dart';

class LlmApiClient {
  final Dio _dio;
  final String baseUrl;
  final String apiKey;

  LlmApiClient({
    required this.baseUrl,
    required this.apiKey,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };
  }

  /// Sends a message to the LLM API and returns the response
  Future<String> sendMessage(String userMessage) async {
    try {
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': 'gpt-3.5-turbo', // Default model
          'messages': [
            {
              'role': 'user',
              'content': userMessage,
            }
          ],
          'stream': false, // Set to true for streaming
        },
      );

      final data = response.data as Map<String, dynamic>;
      final choices = data['choices'] as List;
      final firstChoice = choices.first as Map<String, dynamic>;
      final messageData = firstChoice['message'] as Map<String, dynamic>;
      
      return messageData['content'] as String;
    } on DioException catch (e) {
      throw LlmApiException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw LlmApiException(message: e.toString());
    }
  }

  /// Sends a message and returns a stream of response chunks
  Stream<String> sendMessageStream(String userMessage) async* {
    try {
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'user',
              'content': userMessage,
            }
          ],
          'stream': true,
        },
        options: Options(
          responseType: ResponseType.stream,
        ),
      );

      await for (final chunk in response.data.stream) {
        final lines = chunk.toString().split('\n');
        for (final line in lines) {
          if (line.startsWith('data: ')) {
            final data = line.substring(6);
            if (data == '[DONE]') {
              return;
            }
            try {
              // This is a simplified mock implementation
              // In real implementation, you would parse SSE data
              yield data;
            } catch (e) {
              // Skip malformed chunks
            }
          }
        }
      }
    } on DioException catch (e) {
      throw LlmApiException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw LlmApiException(message: e.toString());
    }
  }
}

class LlmApiException implements Exception {
  final String message;
  final int? statusCode;

  LlmApiException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() {
    return 'LlmApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }
}