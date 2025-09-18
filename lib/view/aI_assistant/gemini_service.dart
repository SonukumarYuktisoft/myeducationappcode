import 'package:dio/dio.dart';
import 'package:get/get.dart';

class GeminiService extends GetxService {
  late Dio _dio;
  static const String _baseUrl = 'https://generativelanguage.googleapis.com/v1beta';
  static const String _apiKey = 'AIzaSyAItAj_p8SGYPHX9v81qFCuSiCzx-vxiuA'; // Replace with your API key
  
  @override
  void onInit() {
    super.onInit();
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'x-goog-api-key': _apiKey, // Updated header format
      },
    ));
    
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
  
  Future<String> generateResponse(String message) async {
    try {
      final response = await _dio.post(
        '/models/gemini-2.0-flash:generateContent', // Updated to latest model
        data: {
          'contents': [
            {
              'parts': [
                {'text': message}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 2048, // Increased token limit
            'topP': 0.95,
            'topK': 40,
          },
          'safetySettings': [
            {
              'category': 'HARM_CATEGORY_HARASSMENT',
              'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
            },
            {
              'category': 'HARM_CATEGORY_HATE_SPEECH',
              'threshold': 'BLOCK_MEDIUM_AND_ABOVE'
            }
          ]
        },
      );
      
      if (response.statusCode == 200) {
        final candidates = response.data['candidates'] as List;
        if (candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          final parts = content['parts'] as List;
          if (parts.isNotEmpty) {
            return parts[0]['text'] ?? 'Sorry, I could not generate a response.';
          }
        }
      }
      return 'Sorry, I could not generate a response.';
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Response data: ${e.response?.data}');
      if (e.response?.statusCode == 400) {
        return 'Invalid request. Please check your message.';
      } else if (e.response?.statusCode == 403) {
        return 'API key is invalid or quota exceeded.';
      } else if (e.response?.statusCode == 429) {
        return 'Rate limit exceeded. Please try again later.';
      }
      return 'Network error. Please try again.';
    } catch (e) {
      print('Error: $e');
      return 'An unexpected error occurred.';
    }
  }

  // Additional method for streaming responses (optional)
  Future<Stream<String>> generateStreamResponse(String message) async {
    try {
      final response = await _dio.post(
        '/models/gemini-2.0-flash:streamGenerateContent',
        data: {
          'contents': [
            {
              'parts': [
                {'text': message}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 2048,
          }
        },
        options: Options(
          responseType: ResponseType.stream,
        ),
      );
      
      return response.data.stream
          .map((data) => String.fromCharCodes(data))
          .where((chunk) => chunk.isNotEmpty);
    } catch (e) {
      print('Stream error: $e');
      return Stream.value('Error occurred during streaming.');
    }
  }
}