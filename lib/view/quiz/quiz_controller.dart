import 'dart:async';
import 'dart:convert';

import 'package:education/view/aI_assistant/gemini_service.dart';
import 'package:education/view/quiz/quiz_screen.dart';
import 'package:get/get.dart';

class ExamModel {
  final String id;
  final String name;
  final String description;
  final List<String> subjects;
  final String icon;

  ExamModel({
    required this.id,
    required this.name,
    required this.description,
    required this.subjects,
    required this.icon,
  });
}

class QuestionModel {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;

  QuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctAnswer: json['correctAnswer'] ?? 0,
      explanation: json['explanation'] ?? '',
    );
  }
}

class FontFamily {
  static const String regular = 'Regular';
  static const String medium = 'Medium';
  static const String bold = 'Bold';
}

class QuizController extends GetxController {
  // Lazy initialization of GeminiService
  GeminiService get _geminiService => Get.find<GeminiService>();
  
  // Observable variables
  final currentQuestionIndex = 0.obs;
  final selectedAnswer = (-1).obs;
  final score = 0.obs;
  final timeRemaining = 0.obs;
  final isQuizCompleted = false.obs;
  final isLoading = false.obs;
  final questions = <QuestionModel>[].obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  
  Timer? _timer;
  late int totalTime;
  late String examType;
  late String language;
  late int numberOfQuestions;

  @override
  void onInit() {
    super.onInit();
    // Ensure GeminiService is available
    if (!Get.isRegistered<GeminiService>()) {
      Get.put(GeminiService());
    }
  }

  void initializeQuiz({
    required String exam,
    required String lang,
    required int questionsCount,
    required int timeInMinutes,
  }) {
    // Reset all values
    _resetQuizState();
    
    examType = exam;
    language = lang;
    numberOfQuestions = questionsCount;
    totalTime = timeInMinutes * 60;
    timeRemaining.value = totalTime;
    
    generateQuestions();
  }

  void _resetQuizState() {
    currentQuestionIndex.value = 0;
    selectedAnswer.value = -1;
    score.value = 0;
    isQuizCompleted.value = false;
    hasError.value = false;
    errorMessage.value = '';
    questions.clear();
    _timer?.cancel();
  }

  Future<void> generateQuestions() async {
    isLoading.value = true;
    hasError.value = false;
    
    try {
      String prompt = _buildPrompt();
      String response = await _geminiService.generateResponse(prompt);
      
      // Clean and parse the response
      String cleanResponse = _cleanJsonResponse(response);
      
      try {
        Map<String, dynamic> jsonResponse = json.decode(cleanResponse);
        
        if (jsonResponse.containsKey('questions') && 
            jsonResponse['questions'] is List &&
            jsonResponse['questions'].isNotEmpty) {
          
          List<dynamic> questionsJson = jsonResponse['questions'];
          questions.value = questionsJson
              .map((q) => QuestionModel.fromJson(q))
              .where((question) => _isValidQuestion(question))
              .take(numberOfQuestions)
              .toList();
              
          if (questions.isEmpty) {
            throw Exception('No valid questions generated');
          }
          
          // Start timer only after questions are loaded
          _startTimer();
        } else {
          throw Exception('Invalid response format');
        }
      } catch (jsonError) {
        throw Exception('Failed to parse questions: $jsonError');
      }
    } catch (e) {
      print('Error generating questions: $e');
      hasError.value = true;
      errorMessage.value = 'Failed to generate questions. Please check your internet connection and try again.';
      
      // Fallback to sample questions only in development
      if (Get.testMode) {
        _createSampleQuestions();
        _startTimer();
      }
    } finally {
      isLoading.value = false;
    }
  }

  String _buildPrompt() {
    return """
Generate exactly $numberOfQuestions multiple choice questions for $examType exam in $language language.
Each question must have exactly 4 options and be relevant to the $examType syllabus.

Return ONLY valid JSON in this exact format (no additional text):
{
  "questions": [
    {
      "question": "Clear, specific question text",
      "options": ["Option A", "Option B", "Option C", "Option D"],
      "correctAnswer": 0,
      "explanation": "Brief explanation of why this answer is correct"
    }
  ]
}

Requirements:
- Questions must be appropriate difficulty for $examType
- Each question must have exactly 4 options
- correctAnswer must be 0, 1, 2, or 3 (index of correct option)
- All text should be in $language language
- Focus on important topics from $examType syllabus
""";
  }

  String _cleanJsonResponse(String response) {
    String cleaned = response.trim();
    
    // Remove markdown formatting
    if (cleaned.contains('```json')) {
      cleaned = cleaned.split('```json')[1].split('```')[0].trim();
    } else if (cleaned.contains('```')) {
      cleaned = cleaned.split('```')[1].split('```')[0].trim();
    }
    
    // Remove any leading/trailing non-JSON content
    int startIndex = cleaned.indexOf('{');
    int endIndex = cleaned.lastIndexOf('}');
    
    if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
      cleaned = cleaned.substring(startIndex, endIndex + 1);
    }
    
    return cleaned;
  }

  bool _isValidQuestion(QuestionModel question) {
    return question.question.isNotEmpty &&
           question.options.length == 4 &&
           question.correctAnswer >= 0 &&
           question.correctAnswer < 4 &&
           question.options.every((option) => option.isNotEmpty);
  }

  void _createSampleQuestions() {
    questions.value = List.generate(numberOfQuestions, (index) => 
      QuestionModel(
        question: "Sample question ${index + 1} for $examType exam. This is a placeholder question for testing purposes.",
        options: [
          "Sample Option A",
          "Sample Option B", 
          "Sample Option C",
          "Sample Option D"
        ],
        correctAnswer: index % 4, // Vary correct answers
        explanation: "This is a sample explanation for testing purposes.",
      )
    );
  }

  void _startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0 && !isQuizCompleted.value) {
        timeRemaining.value--;
      } else {
        _completeQuiz();
      }
    });
  }

  void selectAnswer(int answerIndex) {
    if (answerIndex >= 0 && answerIndex < 4 && !isQuizCompleted.value) {
      selectedAnswer.value = answerIndex;
    }
  }

  void nextQuestion() {
    if (selectedAnswer.value == -1 || isQuizCompleted.value) return;
    
    // Check if answer is correct
    if (selectedAnswer.value == questions[currentQuestionIndex.value].correctAnswer) {
      score.value++;
    }
    
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
      selectedAnswer.value = -1;
    } else {
      _completeQuiz();
    }
  }

  void _completeQuiz() {
    if (isQuizCompleted.value) return;
    
    _timer?.cancel();
    isQuizCompleted.value = true;
    
    // Navigate to results screen
    Get.off(() => ResultScreen());
  }

  void retryQuiz() {
    generateQuestions();
  }

  String get formattedTime {
    int minutes = timeRemaining.value ~/ 60;
    int seconds = timeRemaining.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get progressPercentage {
    if (questions.isEmpty) return 0.0;
    return (currentQuestionIndex.value + 1) / questions.length;
  }

  bool get canProceed => selectedAnswer.value != -1 && !isQuizCompleted.value;

  String get nextButtonText {
    if (questions.isEmpty) return 'Loading...';
    return currentQuestionIndex.value == questions.length - 1 
        ? 'Finish Quiz' 
        : 'Next Question';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}