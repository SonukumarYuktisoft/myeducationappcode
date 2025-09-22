import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/view/aI_assistant/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';

// Question Model
class Question {
  final int id;
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String explanation;
  final String subject;
  final String difficulty;

  Question({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
    required this.subject,
    required this.difficulty,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] ?? 0,
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctAnswer: json['correctAnswer'] ?? 0,
      explanation: json['explanation'] ?? '',
      subject: json['subject'] ?? '',
      difficulty: json['difficulty'] ?? 'Medium',
    );
  }
}

// Test Result Model
class TestResult {
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final int unanswered;
  final Duration timeTaken;
  final Map<String, int> subjectWiseScore;
  final double percentage;
  final List<int> wrongQuestionIds;

  TestResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.unanswered,
    required this.timeTaken,
    required this.subjectWiseScore,
    required this.percentage,
    required this.wrongQuestionIds,
  });
}

// Mock Test Controller (keeping the same logic)
class MockTestController extends GetxController {
  final GeminiService _geminiService = Get.put(GeminiService());
  
  var questions = <Question>[].obs;
  var currentQuestionIndex = 0.obs;
  var selectedAnswers = <int, int>{}.obs;
  var timeRemaining = 3600.obs;
  var isTestActive = false.obs;
  var isLoading = false.obs;
  var testResult = Rx<TestResult?>(null);
  
  Timer? _timer;
  final testSubjects = ['Mathematics', 'Science', 'English', 'General Knowledge', 'Reasoning'];

  @override
  void onInit() {
    super.onInit();
    generateQuestions();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future<void> generateQuestions() async {
    isLoading.value = true;
    
    try {
      String prompt = '''
Generate 20 multiple-choice questions for a competitive exam in JSON format. Include questions from Mathematics, Science, English, General Knowledge, and Reasoning (4 from each subject). Each question should have:

IMPORTANT FORMATTING RULES:
- Keep all text short and simple
- No special characters or quotes in text
- No line breaks in strings
- Keep explanations under 50 characters
- Use simple language only

Format as valid JSON array:
[
  {
    "id": 1,
    "question": "What is 2 plus 2",
    "options": ["1", "2", "3", "4"],
    "correctAnswer": 3,
    "explanation": "Basic addition",
    "subject": "Mathematics",
    "difficulty": "Easy"
  }
]

Generate exactly 20 questions following this format strictly.
''';

      String response = await _geminiService.generateResponse(prompt);
      
      if (await _tryParseQuestions(response)) {
        // Successfully parsed, generate more questions
        await _generateMoreQuestions();
      } else {
        print('Failed to parse AI questions, using sample questions');
        generateSampleQuestions();
      }
      
    } catch (e) {
      print('Error generating questions: $e');
      generateSampleQuestions();
    }
    
    isLoading.value = false;
  }

  Future<bool> _tryParseQuestions(String response) async {
    try {
      // Clean the response
      String cleanResponse = _cleanJsonResponse(response);
      
      // Validate and fix JSON
      cleanResponse = _fixJsonFormat(cleanResponse);
      
      // Parse JSON
      List<dynamic> questionsJson = jsonDecode(cleanResponse);
      
      // Validate questions
      List<Question> parsedQuestions = [];
      for (var q in questionsJson) {
        try {
          Question question = Question.fromJson(q);
          if (_isValidQuestion(question)) {
            parsedQuestions.add(question);
          }
        } catch (e) {
          print('Error parsing individual question: $e');
          continue;
        }
      }
      
      if (parsedQuestions.isNotEmpty) {
        questions.value = parsedQuestions;
        return true;
      }
      
    } catch (e) {
      print('JSON Parse Error: $e');
      print('Response preview: ${response.substring(0, response.length > 500 ? 500 : response.length)}...');
    }
    
    return false;
  }

  String _cleanJsonResponse(String response) {
    String cleanResponse = response.trim();
    
    // Extract JSON from markdown blocks
    if (cleanResponse.contains('```json')) {
      cleanResponse = cleanResponse.split('```json')[1].split('```')[0].trim();
    } else if (cleanResponse.contains('```')) {
      cleanResponse = cleanResponse.split('```')[1].split('```')[0].trim();
    }
    
    // Remove any text before the first [
    int startIndex = cleanResponse.indexOf('[');
    if (startIndex != -1) {
      cleanResponse = cleanResponse.substring(startIndex);
    }
    
    // Remove any text after the last ]
    int endIndex = cleanResponse.lastIndexOf(']');
    if (endIndex != -1) {
      cleanResponse = cleanResponse.substring(0, endIndex + 1);
    }
    
    return cleanResponse;
  }

  String _fixJsonFormat(String jsonString) {
    // Fix common JSON issues
    jsonString = jsonString.replaceAll('\n', ' ');
    jsonString = jsonString.replaceAll('\r', ' ');
    jsonString = jsonString.replaceAll('\t', ' ');
    
    // Fix multiple spaces
    jsonString = jsonString.replaceAll(RegExp(r'\s+'), ' ');
    
    // Fix trailing commas
    jsonString = jsonString.replaceAll(RegExp(r',(\s*[}\]])'), r'$1');
    
    return jsonString.trim();
  }

  bool _isValidQuestion(Question question) {
    return question.question.isNotEmpty &&
           question.options.length == 4 &&
           question.correctAnswer >= 0 &&
           question.correctAnswer < 4 &&
           question.subject.isNotEmpty &&
           testSubjects.contains(question.subject);
  }

  Future<void> _generateMoreQuestions() async {
    // Generate questions in smaller batches to avoid parsing issues
    int batchSize = 20;
    int remainingQuestions = 100 - questions.length;
    
    while (remainingQuestions > 0 && questions.length < 100) {
      int currentBatch = remainingQuestions > batchSize ? batchSize : remainingQuestions;
      
      try {
        await _generateQuestionBatch(currentBatch, questions.length + 1);
        remainingQuestions = 100 - questions.length;
        
        // Add a small delay to avoid overwhelming the API
        await Future.delayed(Duration(milliseconds: 500));
      } catch (e) {
        print('Error generating batch: $e');
        break;
      }
    }
    
    // Fill remaining with sample questions if needed
    if (questions.length < 100) {
      _fillWithSampleQuestions(100 - questions.length);
    }
  }

  Future<void> _generateQuestionBatch(int count, int startId) async {
    String prompt = '''
Generate exactly $count multiple-choice questions starting from ID $startId.

STRICT RULES:
- Valid JSON array format only
- No special characters or quotes in text
- Keep all strings short and simple
- No line breaks in any text
- Subjects: Mathematics, Science, English, General Knowledge, Reasoning

Example format:
[
  {
    "id": $startId,
    "question": "Simple question text here",
    "options": ["A", "B", "C", "D"],
    "correctAnswer": 1,
    "explanation": "Short answer",
    "subject": "Mathematics",
    "difficulty": "Easy"
  }
]
''';
    
    try {
      String response = await _geminiService.generateResponse(prompt);
      
      String cleanResponse = _cleanJsonResponse(response);
      cleanResponse = _fixJsonFormat(cleanResponse);
      
      List<dynamic> batchJson = jsonDecode(cleanResponse);
      
      for (var q in batchJson) {
        try {
          Question question = Question.fromJson(q);
          if (_isValidQuestion(question)) {
            questions.add(question);
          }
        } catch (e) {
          print('Error parsing batch question: $e');
          continue;
        }
      }
      
    } catch (e) {
      print('Error in batch generation: $e');
    }
  }

  void _fillWithSampleQuestions(int count) {
    int startId = questions.length + 1;
    
    for (int i = 0; i < count; i++) {
      questions.add(Question(
        id: startId + i,
        question: "Sample question ${startId + i}: What is the answer to this question?",
        options: ["Option A", "Option B", "Option C", "Option D"],
        correctAnswer: i % 4,
        explanation: "This is a sample explanation for question ${startId + i}",
        subject: testSubjects[i % testSubjects.length],
        difficulty: ['Easy', 'Medium', 'Hard'][i % 3],
      ));
    }
  }

  // Remove the old generateAdditionalQuestions method since it's replaced by the new batching system
  
  void generateSampleQuestions() {
    // Enhanced sample questions with better variety
    questions.value = _createSampleQuestionSet();
  }

  List<Question> _createSampleQuestionSet() {
    List<Question> sampleQuestions = [];
    
    // Mathematics Questions (20)
    sampleQuestions.addAll([
      Question(id: 1, question: "What is 15 + 27?", options: ["40", "41", "42", "43"], correctAnswer: 2, explanation: "15 + 27 = 42", subject: "Mathematics", difficulty: "Easy"),
      Question(id: 2, question: "What is 8 × 9?", options: ["72", "73", "71", "70"], correctAnswer: 0, explanation: "8 × 9 = 72", subject: "Mathematics", difficulty: "Easy"),
      Question(id: 3, question: "What is 144 ÷ 12?", options: ["11", "12", "13", "14"], correctAnswer: 1, explanation: "144 ÷ 12 = 12", subject: "Mathematics", difficulty: "Medium"),
      Question(id: 4, question: "What is the square root of 81?", options: ["8", "9", "10", "11"], correctAnswer: 1, explanation: "√81 = 9", subject: "Mathematics", difficulty: "Medium"),
      Question(id: 5, question: "What is 2³?", options: ["6", "8", "9", "12"], correctAnswer: 1, explanation: "2³ = 8", subject: "Mathematics", difficulty: "Easy"),
    ]);
    
    // Science Questions (20)
    sampleQuestions.addAll([
      Question(id: 21, question: "What is the chemical symbol for water?", options: ["H2O", "HO2", "H3O", "OH2"], correctAnswer: 0, explanation: "Water is H2O", subject: "Science", difficulty: "Easy"),
      Question(id: 22, question: "How many bones are in the human body?", options: ["206", "207", "208", "209"], correctAnswer: 0, explanation: "Humans have 206 bones", subject: "Science", difficulty: "Medium"),
      Question(id: 23, question: "What planet is closest to the sun?", options: ["Venus", "Mercury", "Earth", "Mars"], correctAnswer: 1, explanation: "Mercury is closest to sun", subject: "Science", difficulty: "Easy"),
      Question(id: 24, question: "What gas do plants absorb from air?", options: ["Oxygen", "Nitrogen", "Carbon dioxide", "Hydrogen"], correctAnswer: 2, explanation: "Plants absorb CO2", subject: "Science", difficulty: "Easy"),
      Question(id: 25, question: "What is the speed of light?", options: ["300,000 km/s", "150,000 km/s", "450,000 km/s", "600,000 km/s"], correctAnswer: 0, explanation: "Light speed is ~300,000 km/s", subject: "Science", difficulty: "Hard"),
    ]);
    
    // English Questions (20)
    sampleQuestions.addAll([
      Question(id: 41, question: "What is the plural of 'child'?", options: ["childs", "children", "childes", "child"], correctAnswer: 1, explanation: "Plural of child is children", subject: "English", difficulty: "Easy"),
      Question(id: 42, question: "Which is a synonym for 'happy'?", options: ["sad", "joyful", "angry", "tired"], correctAnswer: 1, explanation: "Joyful means happy", subject: "English", difficulty: "Easy"),
      Question(id: 43, question: "What type of word is 'quickly'?", options: ["noun", "verb", "adverb", "adjective"], correctAnswer: 2, explanation: "Quickly is an adverb", subject: "English", difficulty: "Medium"),
      Question(id: 44, question: "Complete: He ___ to school daily", options: ["go", "goes", "going", "gone"], correctAnswer: 1, explanation: "He goes - third person singular", subject: "English", difficulty: "Easy"),
      Question(id: 45, question: "What is an antonym for 'difficult'?", options: ["hard", "easy", "tough", "complex"], correctAnswer: 1, explanation: "Easy is opposite of difficult", subject: "English", difficulty: "Easy"),
    ]);
    
    // General Knowledge Questions (20)
    sampleQuestions.addAll([
      Question(id: 61, question: "Who wrote Romeo and Juliet?", options: ["Shakespeare", "Dickens", "Austen", "Wilde"], correctAnswer: 0, explanation: "Shakespeare wrote Romeo and Juliet", subject: "General Knowledge", difficulty: "Easy"),
      Question(id: 62, question: "What is the capital of France?", options: ["London", "Berlin", "Paris", "Madrid"], correctAnswer: 2, explanation: "Paris is capital of France", subject: "General Knowledge", difficulty: "Easy"),
      Question(id: 63, question: "In which year did World War 2 end?", options: ["1944", "1945", "1946", "1947"], correctAnswer: 1, explanation: "WW2 ended in 1945", subject: "General Knowledge", difficulty: "Medium"),
      Question(id: 64, question: "What is the largest ocean?", options: ["Atlantic", "Indian", "Arctic", "Pacific"], correctAnswer: 3, explanation: "Pacific is the largest ocean", subject: "General Knowledge", difficulty: "Easy"),
      Question(id: 65, question: "Who painted the Mona Lisa?", options: ["Van Gogh", "Da Vinci", "Picasso", "Rembrandt"], correctAnswer: 1, explanation: "Leonardo da Vinci painted Mona Lisa", subject: "General Knowledge", difficulty: "Medium"),
    ]);
    
    // Reasoning Questions (20)
    sampleQuestions.addAll([
      Question(id: 81, question: "If A=1, B=2, C=3, what is D?", options: ["3", "4", "5", "6"], correctAnswer: 1, explanation: "D is 4th letter, so D=4", subject: "Reasoning", difficulty: "Easy"),
      Question(id: 82, question: "Complete: 2, 4, 6, 8, __", options: ["9", "10", "11", "12"], correctAnswer: 1, explanation: "Even numbers sequence: 10", subject: "Reasoning", difficulty: "Easy"),
      Question(id: 83, question: "If all roses are flowers and all flowers are plants, then roses are:", options: ["plants", "trees", "fruits", "none"], correctAnswer: 0, explanation: "Roses are plants by logic", subject: "Reasoning", difficulty: "Medium"),
      Question(id: 84, question: "What comes next: AB, BC, CD, __", options: ["DE", "EF", "DC", "DD"], correctAnswer: 0, explanation: "Alphabetic sequence: DE", subject: "Reasoning", difficulty: "Easy"),
      Question(id: 85, question: "If 5 + 3 = 28, 9 + 1 = 810, then 8 + 6 = ?", options: ["214", "148", "246", "814"], correctAnswer: 0, explanation: "Pattern: (a-b)(a+b) = 214", subject: "Reasoning", difficulty: "Hard"),
    ]);
    
    // Fill remaining slots with more questions
    int currentId = 86;
    while (sampleQuestions.length < 100) {
      int subjectIndex = (currentId - 86) % testSubjects.length;
      String subject = testSubjects[subjectIndex];
      String difficulty = ['Easy', 'Medium', 'Hard'][(currentId - 86) % 3];
      
      sampleQuestions.add(Question(
        id: currentId,
        question: "Sample $subject question ${currentId}: What is the correct answer?",
        options: ["Option A", "Option B", "Option C", "Option D"],
        correctAnswer: currentId % 4,
        explanation: "This is explanation for question $currentId",
        subject: subject,
        difficulty: difficulty,
      ));
      
      currentId++;
    }
    
    return sampleQuestions;
  }

  void startTest() {
    isTestActive.value = true;
    timeRemaining.value = 3600;
    selectedAnswers.clear();
    currentQuestionIndex.value = 0;
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeRemaining.value > 0) {
        timeRemaining.value--;
      } else {
        submitTest();
      }
    });
  }

  void selectAnswer(int questionIndex, int answerIndex) {
    selectedAnswers[questionIndex] = answerIndex;
  }

  void nextQuestion() {
    if (currentQuestionIndex.value < questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  void goToQuestion(int index) {
    currentQuestionIndex.value = index;
  }

  void submitTest() async {
    _timer?.cancel();
    isTestActive.value = false;
    
    int correct = 0;
    int wrong = 0;
    int unanswered = 0;
    List<int> wrongQuestionIds = [];
    Map<String, int> subjectWiseScore = {};
    
    for (String subject in testSubjects) {
      subjectWiseScore[subject] = 0;
    }
    
    for (int i = 0; i < questions.length; i++) {
      Question question = questions[i];
      
      if (selectedAnswers.containsKey(i)) {
        if (selectedAnswers[i] == question.correctAnswer) {
          correct++;
          subjectWiseScore[question.subject] = (subjectWiseScore[question.subject] ?? 0) + 1;
        } else {
          wrong++;
          wrongQuestionIds.add(question.id);
        }
      } else {
        unanswered++;
        wrongQuestionIds.add(question.id);
      }
    }
    
    Duration timeTaken = Duration(seconds: 3600 - timeRemaining.value);
    double percentage = (correct / questions.length) * 100;
    
    testResult.value = TestResult(
      totalQuestions: questions.length,
      correctAnswers: correct,
      wrongAnswers: wrong,
      unanswered: unanswered,
      timeTaken: timeTaken,
      subjectWiseScore: subjectWiseScore,
      percentage: percentage,
      wrongQuestionIds: wrongQuestionIds,
    );
    
    await generateTestAnalysis();
  }

  Future<void> generateTestAnalysis() async {
    if (testResult.value == null) return;
    
    TestResult result = testResult.value!;
    
    String analysisPrompt = '''
Generate a detailed performance analysis for a mock test with the following results:

Total Questions: ${result.totalQuestions}
Correct Answers: ${result.correctAnswers}
Wrong Answers: ${result.wrongAnswers}
Unanswered: ${result.unanswered}
Percentage: ${result.percentage.toStringAsFixed(2)}%
Time Taken: ${result.timeTaken.inMinutes} minutes ${result.timeTaken.inSeconds % 60} seconds

Subject-wise Performance:
${result.subjectWiseScore.entries.map((e) => "${e.key}: ${e.value} correct").join('\n')}

Provide:
1. Overall performance assessment
2. Strengths and weaknesses
3. Subject-wise analysis
4. Recommendations for improvement
5. Study plan suggestions
6. Time management feedback

Make it detailed but concise, motivational yet honest.
''';
    
    try {
      String analysis = await _geminiService.generateResponse(analysisPrompt);
      Get.to(() => ResultScreen(), arguments: {'analysis': analysis});
    } catch (e) {
      print('Error generating analysis: $e');
      Get.to(() => ResultScreen());
    }
  }

  String getFormattedTime() {
    int minutes = timeRemaining.value ~/ 60;
    int seconds = timeRemaining.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

// Modern Home Screen
class MockTestQuestionScreen extends StatefulWidget {
  @override
  State<MockTestQuestionScreen> createState() => _MockTestQuestionScreenState();
}

class _MockTestQuestionScreenState extends State<MockTestQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MockTestController());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primaryColor.withValues(alpha: 0.1),
              AppColors.whiteColor,
              AppColors.primaryColor.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return _buildLoadingState();
            }
            
            return _buildMainContent(context, controller);
          }),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.clr8D8D8D.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: AppColors.linearButtonColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
                strokeWidth: 3,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Generating AI Questions...',
              style: TextStyleCustom.headingStyle(
                fontSize: 18,
                color: AppColors.clr222222,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please wait while we create your personalized test',
              style: TextStyleCustom.normalStyle(
                color: AppColors.clr8D8D8D,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, MockTestController controller) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            // Header Section
            _buildHeader(),
            
            SizedBox(height: 40),
            
            // Main Card
            _buildMainCard(context, controller),
            
            SizedBox(height: 32),
            
            // Features Grid
            _buildFeaturesGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: AppColors.linearButtonColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryColor.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.quiz_outlined,
            color: AppColors.whiteColor,
            size: 40,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Mock Test Challenge',
          style: TextStyleCustom.headingStyle(
            fontSize: 28,
            color: AppColors.clr222222,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Test your knowledge with AI-generated questions',
          style: TextStyleCustom.normalStyle(
            fontSize: 16,
            color: AppColors.clr8D8D8D,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMainCard(BuildContext context, MockTestController controller) {
    return Container(
      padding: EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.clr8D8D8D.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: Offset(0, 15),
          ),
        ],
        border: Border.all(
          color: AppColors.clrD6D6D6.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Test Info
          _buildTestInfo(),
          
          SizedBox(height: 24),
          
          // Instructions
          _buildInstructions(),
          
          SizedBox(height: 32),
          
          // Start Button
          _buildStartButton(context, controller),
        ],
      ),
    );
  }

  Widget _buildTestInfo() {
    return Row(
      children: [
        Expanded(
          child: _buildInfoItem(
            icon: Icons.quiz,
            title: '100',
            subtitle: 'Questions',
          ),
        ),
        Container(
          height: 60,
          width: 1,
          color: AppColors.clrD6D6D6,
        ),
        Expanded(
          child: _buildInfoItem(
            icon: Icons.access_time,
            title: '60',
            subtitle: 'Minutes',
          ),
        ),
        Container(
          height: 60,
          width: 1,
          color: AppColors.clrD6D6D6,
        ),
        Expanded(
          child: _buildInfoItem(
            icon: Icons.psychology,
            title: 'AI',
            subtitle: 'Generated',
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyleCustom.headingStyle(
            fontSize: 20,
            color: AppColors.clr222222,
          ),
        ),
        Text(
          subtitle,
          style: TextStyleCustom.normalStyle(
            fontSize: 12,
            color: AppColors.clr8D8D8D,
          ),
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    final instructions = [
      {'icon': Icons.access_time, 'text': 'Complete 100 questions in 60 minutes'},
      {'icon': Icons.equalizer, 'text': 'Each question carries equal marks'},
      {'icon': Icons.navigation, 'text': 'Navigate between questions freely'},
      {'icon': Icons.check_circle, 'text': 'Submit before time expires'},
    ];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Instructions',
            style: TextStyleCustom.headingStyle(
              fontSize: 16,
              color: AppColors.clr222222,
            ),
          ),
          SizedBox(height: 12),
          ...instructions.map((instruction) => Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Icon(
                  instruction['icon'] as IconData,
                  color: AppColors.primaryColor,
                  size: 16,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    instruction['text'] as String,
                    style: TextStyleCustom.normalStyle(
                      fontSize: 14,
                      color: AppColors.clr606060,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
        ],
      ),
    );
  }

  Widget _buildStartButton(BuildContext context, MockTestController controller) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: AppColors.linearButtonColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          controller.startTest();
          Get.to(() => TestScreen());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_arrow_rounded,
              color: AppColors.whiteColor,
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              'Start Test',
              style: TextStyleCustom.headingStyle(
                fontSize: 18,
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesGrid() {
    final features = [
      {'icon': Icons.auto_awesome, 'title': 'AI Powered', 'subtitle': 'Smart question generation'},
      {'icon': Icons.analytics, 'title': 'Detailed Analysis', 'subtitle': 'Performance insights'},
      {'icon': Icons.school, 'title': 'Multiple Subjects', 'subtitle': '5 different categories'},
      {'icon': Icons.timer, 'title': 'Timed Practice', 'subtitle': 'Real exam simulation'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.clrD6D6D6.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
              ),
              SizedBox(height: 12),
              Text(
                feature['title'] as String,
                style: TextStyleCustom.headingStyle(
                  fontSize: 14,
                  color: AppColors.clr222222,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                feature['subtitle'] as String,
                style: TextStyleCustom.normalStyle(
                  fontSize: 12,
                  color: AppColors.clr8D8D8D,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}

// Modern Test Screen
class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MockTestController>();
    
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor.withValues(alpha: 0.05),
              AppColors.whiteColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildModernAppBar(controller),
              _buildProgressSection(controller),
              Expanded(child: _buildQuestionContent(context, controller)),
              _buildBottomNavigation(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernAppBar(MockTestController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Mock Test',
            style: TextStyleCustom.headingStyle(
              fontSize: 20,
              color: AppColors.clr222222,
            ),
          ),
          Obx(() => Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: AppColors.linearButtonColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  color: AppColors.whiteColor,
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  controller.getFormattedTime(),
                  style: TextStyleCustom.headingStyle(
                    fontSize: 16,
                    color: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildProgressSection(MockTestController controller) {
    return Obx(() => Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.clr8D8D8D.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${controller.currentQuestionIndex.value + 1} of 100',
                style: TextStyleCustom.normalStyle(
                  fontSize: 14,
                  color: AppColors.clr8D8D8D,
                ),
              ),
              Text(
                '${((controller.currentQuestionIndex.value + 1) / controller.questions.length * 100).toInt()}% Complete',
                style: TextStyleCustom.normalStyle(
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (controller.currentQuestionIndex.value + 1) / controller.questions.length,
              backgroundColor: AppColors.clrD6D6D6,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              minHeight: 6,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildQuestionContent(BuildContext context, MockTestController controller) {
    return Obx(() {
      if (controller.questions.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      Question currentQuestion = controller.questions[controller.currentQuestionIndex.value];

      return Container(
        margin: EdgeInsets.all(24),
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.clr8D8D8D.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subject and Difficulty
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    currentQuestion.subject,
                    style: TextStyleCustom.normalStyle(
                      fontSize: 12,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(currentQuestion.difficulty).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    currentQuestion.difficulty,
                    style: TextStyleCustom.normalStyle(
                      fontSize: 12,
                      color: _getDifficultyColor(currentQuestion.difficulty),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Question Text
            Text(
              currentQuestion.question,
              style: TextStyleCustom.headingStyle(
                fontSize: 18,
                color: AppColors.clr222222,
              ),
            ),

            SizedBox(height: 24),

            // Options
            Expanded(
  child: Obx(() {
    final currentIndex = controller.currentQuestionIndex.value;
    final selected = controller.selectedAnswers[currentIndex];

    return ListView.builder(
      itemCount: controller.questions[currentIndex].options.length,
      itemBuilder: (context, index) {
        final isSelected = selected == index;

        return Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              controller.selectAnswer(currentIndex, index);
            },
            borderRadius: BorderRadius.circular(12),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppColors.primaryColor.withOpacity(0.1)
                    : AppColors.textFieldBackgroundColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected 
                      ? AppColors.primaryColor 
                      : AppColors.clrD6D6D6,
                  width: isSelected ? 2 : 1,
                )),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? AppColors.primaryColor 
                          : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected 
                            ? AppColors.primaryColor 
                            : AppColors.clrC8C7CC,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        String.fromCharCode(65 + index),
                        style: TextStyleCustom.headingStyle(
                          fontSize: 14,
                          color: isSelected 
                              ? AppColors.whiteColor 
                              : AppColors.clr8D8D8D,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      controller.questions[currentIndex].options[index],
                      style: TextStyleCustom.normalStyle(
                        fontSize: 16,
                        color: isSelected 
                            ? AppColors.clr222222 
                            : AppColors.clr606060,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }),
),

          ],
        ),
      );
    });
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Colors.green;
      case 'medium':
        return Colors.orange;
      case 'hard':
        return AppColors.redColor;
      default:
        return AppColors.clr8D8D8D;
    }
  }

  Widget _buildBottomNavigation(BuildContext context, MockTestController controller) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.clr8D8D8D.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Obx(() => Row(
        children: [
          // Previous Button
          Expanded(
            child: Container(
              height: 48,
              child: ElevatedButton.icon(
                onPressed: controller.currentQuestionIndex.value > 0
                    ? controller.previousQuestion
                    : null,
                icon: Icon(Icons.arrow_back_ios, size: 16),
                label: Text('Previous'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textFieldBackgroundColor,
                  foregroundColor: AppColors.clr606060,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
          
          SizedBox(width: 12),
          
          // Questions Grid Button
          Container(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                _showModernQuestionNavigator(context, controller);
              },
              child: Icon(Icons.grid_view_rounded),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.clr8D8D8D.withValues(alpha: 0.1),
                foregroundColor: AppColors.clr8D8D8D,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          
          SizedBox(width: 12),
          
          // Next/Submit Button
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                gradient: controller.currentQuestionIndex.value < controller.questions.length - 1
                    ? AppColors.linearButtonColor
                    : LinearGradient(colors: [Colors.green, Colors.green.shade700]),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: controller.currentQuestionIndex.value < controller.questions.length - 1
                    ? controller.nextQuestion
                    : () => _showModernSubmitDialog(context, controller),
                icon: Icon(
                  controller.currentQuestionIndex.value < controller.questions.length - 1
                      ? Icons.arrow_forward_ios
                      : Icons.check_rounded,
                  size: 16,
                ),
                label: Text(
                  controller.currentQuestionIndex.value < controller.questions.length - 1
                      ? 'Next'
                      : 'Submit',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.whiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  void _showModernQuestionNavigator(BuildContext context, MockTestController controller) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question Navigator',
                    style: TextStyleCustom.headingStyle(
                      fontSize: 18,
                      color: AppColors.clr222222,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.clr8D8D8D.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              
              // Legend
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegendItem(
                    color: AppColors.primaryColor,
                    label: 'Current',
                  ),
                  _buildLegendItem(
                    color: Colors.green,
                    label: 'Answered',
                  ),
                  _buildLegendItem(
                    color: AppColors.clrC8C7CC,
                    label: 'Not Answered',
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              Container(
                height: 300,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: controller.questions.length,
                  itemBuilder: (context, index) {
                    bool isAnswered = controller.selectedAnswers.containsKey(index);
                    bool isCurrent = controller.currentQuestionIndex.value == index;

                    return InkWell(
                      onTap: () {
                        controller.goToQuestion(index);
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? AppColors.primaryColor
                              : isAnswered
                                  ? Colors.green.withValues(alpha: 0.1)
                                  : AppColors.clrC8C7CC.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isCurrent
                                ? AppColors.primaryColor
                                : isAnswered
                                    ? Colors.green
                                    : AppColors.clrC8C7CC,
                            width: isCurrent ? 2 : 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyleCustom.headingStyle(
                              fontSize: 12,
                              color: isCurrent
                                  ? AppColors.whiteColor
                                  : isAnswered
                                      ? Colors.green
                                      : AppColors.clr8D8D8D,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(width: 6),
        Text(
          label,
          style: TextStyleCustom.normalStyle(
            fontSize: 12,
            color: AppColors.clr8D8D8D,
          ),
        ),
      ],
    );
  }

  void _showModernSubmitDialog(BuildContext context, MockTestController controller) {
    int unanswered = controller.questions.length - controller.selectedAnswers.length;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.warning_rounded,
                  color: Colors.orange,
                  size: 30,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Submit Test?',
                style: TextStyleCustom.headingStyle(
                  fontSize: 20,
                  color: AppColors.clr222222,
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.clr8D8D8D.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildSubmitStatRow('Answered', '${controller.selectedAnswers.length}', Colors.green),
                    SizedBox(height: 8),
                    _buildSubmitStatRow('Unanswered', '$unanswered', Colors.orange),
                    if (unanswered > 0) ...[
                      SizedBox(height: 12),
                      Text(
                        'Unanswered questions will be marked as incorrect',
                        style: TextStyleCustom.normalStyle(
                          fontSize: 12,
                          color: Colors.orange,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Continue Test'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.clrC8C7CC,
                        foregroundColor: AppColors.clr606060,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.green.shade700],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          controller.submitTest();
                        },
                        child: Text('Submit Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: AppColors.whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitStatRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyleCustom.normalStyle(
            fontSize: 14,
            color: AppColors.clr606060,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyleCustom.headingStyle(
              fontSize: 14,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

// Modern Result Screen
class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MockTestController>();
    final String? analysis = Get.arguments?['analysis'];

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryColor.withValues(alpha: 0.05),
              AppColors.whiteColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (controller.testResult.value == null) {
              return Center(child: CircularProgressIndicator());
            }

            TestResult result = controller.testResult.value!;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildResultHeader(result),
                    SizedBox(height: 24),
                    _buildScoreCard(result),
                    SizedBox(height: 20),
                    _buildStatsGrid(result),
                    SizedBox(height: 20),
                    _buildSubjectWisePerformance(result),
                    if (analysis != null) ...[
                      SizedBox(height: 20),
                      _buildAIAnalysis(analysis),
                    ],
                    SizedBox(height: 32),
                    _buildActionButtons(context, controller),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildResultHeader(TestResult result) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: result.percentage >= 60
                ? LinearGradient(colors: [Colors.green, Colors.green.shade700])
                : LinearGradient(colors: [Colors.orange, Colors.orange.shade700]),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: (result.percentage >= 60 ? Colors.green : Colors.orange)
                    .withValues(alpha: 0.3),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            result.percentage >= 60 ? Icons.emoji_events : Icons.psychology,
            color: AppColors.whiteColor,
            size: 40,
          ),
        ),
        SizedBox(height: 16),
        Text(
          result.percentage >= 60 ? 'Excellent Work!' : 'Keep Practicing!',
          style: TextStyleCustom.headingStyle(
            fontSize: 24,
            color: AppColors.clr222222,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Your test has been completed successfully',
          style: TextStyleCustom.normalStyle(
            fontSize: 16,
            color: AppColors.clr8D8D8D,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(TestResult result) {
    return Container(
      padding: EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.clr8D8D8D.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Score',
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.clr8D8D8D,
            ),
          ),
          SizedBox(height: 16),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(
                  value: result.percentage / 100,
                  strokeWidth: 8,
                  backgroundColor: AppColors.clrD6D6D6,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    result.percentage >= 60 ? Colors.green : Colors.orange,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    '${result.percentage.toStringAsFixed(1)}%',
                    style: TextStyleCustom.headingStyle(
                      fontSize: 28,
                      color: result.percentage >= 60 ? Colors.green : Colors.orange,
                    ),
                  ),
                  Text(
                    '${result.correctAnswers}/100',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 14,
                      color: AppColors.clr8D8D8D,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.access_time, size: 16, color: AppColors.primaryColor),
                SizedBox(width: 8),
                Text(
                  'Time: ${result.timeTaken.inMinutes}m ${result.timeTaken.inSeconds % 60}s',
                  style: TextStyleCustom.normalStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(TestResult result) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.check_circle_rounded,
            title: 'Correct',
            value: result.correctAnswers.toString(),
            color: Colors.green,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.cancel_rounded,
            title: 'Wrong',
            value: result.wrongAnswers.toString(),
            color: AppColors.redColor,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            icon: Icons.help_outline_rounded,
            title: 'Skipped',
            value: result.unanswered.toString(),
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyleCustom.headingStyle(
              fontSize: 20,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyleCustom.normalStyle(
              fontSize: 12,
              color: AppColors.clr8D8D8D,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectWisePerformance(TestResult result) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.clr8D8D8D.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Subject-wise Performance',
            style: TextStyleCustom.headingStyle(
              fontSize: 16,
              color: AppColors.clr222222,
            ),
          ),
          SizedBox(height: 16),
          ...result.subjectWiseScore.entries.map((entry) {
            double percentage = (entry.value / 20) * 100; // Assuming 20 questions per subject
            return Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: TextStyleCustom.normalStyle(
                          fontSize: 14,
                          color: AppColors.clr606060,
                        ),
                      ),
                      Text(
                        '${entry.value}/20',
                        style: TextStyleCustom.headingStyle(
                          fontSize: 14,
                          color: AppColors.clr222222,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: AppColors.clrD6D6D6,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        percentage >= 60 ? Colors.green : 
                        percentage >= 40 ? Colors.orange : AppColors.redColor,
                      ),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildAIAnalysis(String analysis) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  gradient: AppColors.linearButtonColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.psychology,
                  color: AppColors.whiteColor,
                  size: 16,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'AI Performance Analysis',
                style: TextStyleCustom.headingStyle(
                  fontSize: 16,
                  color: AppColors.clr222222,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            analysis,
            style: TextStyleCustom.normalStyle(
              fontSize: 14,
              color: AppColors.clr606060,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, MockTestController controller) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.linearButtonColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.offAll(() => MockTestQuestionScreen());
                  },
                  icon: Icon(Icons.refresh, size: 20),
                  label: Text('Take Another Test'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.whiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  _showDetailedReview(context, controller);
                },
                icon: Icon(Icons.visibility, size: 20),
                label: Text('Review Answers'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.clr8D8D8D.withValues(alpha: 0.1),
                  foregroundColor: AppColors.clr606060,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          width: double.infinity,
          height: 48,
          child: ElevatedButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.home, size: 20),
            label: Text('Back to Home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.whiteColor,
              foregroundColor: AppColors.clr606060,
              elevation: 0,
              side: BorderSide(color: AppColors.clrD6D6D6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDetailedReview(BuildContext context, MockTestController controller) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: AppColors.linearButtonColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.visibility,
                  color: AppColors.whiteColor,
                  size: 30,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Answer Review',
                style: TextStyleCustom.headingStyle(
                  fontSize: 20,
                  color: AppColors.clr222222,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Detailed answer review with explanations will be available in the next update. This feature will help you understand your mistakes and learn from them.',
                style: TextStyleCustom.normalStyle(
                  fontSize: 14,
                  color: AppColors.clr8D8D8D,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  gradient: AppColors.linearButtonColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Got It'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColors.whiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Additional Helper Classes and Extensions for Modern UI

class AppAnimations {
  static const Duration fastAnimation = Duration(milliseconds: 200);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);

  static SlideTransition slideInFromBottom(
    Animation<double> animation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: child,
    );
  }

  static ScaleTransition scaleIn(
    Animation<double> animation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.8,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutBack,
      )),
      child: child,
    );
  }
}

class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Border? border;

  const ModernCard({
    Key? key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.whiteColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 16),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: AppColors.clr8D8D8D.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
        border: border,
      ),
      child: child,
    );
  }
}

class ModernButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonType type;
  final double? width;
  final double? height;

  const ModernButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.icon,
    this.type = ButtonType.primary,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 48,
      decoration: _getButtonDecoration(),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: _getTextColor(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyleCustom.headingStyle(
                fontSize: 16,
                color: _getTextColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _getButtonDecoration() {
    switch (type) {
      case ButtonType.primary:
        return BoxDecoration(
          gradient: AppColors.linearButtonColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        );
      case ButtonType.secondary:
        return BoxDecoration(
          color: AppColors.clr8D8D8D.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        );
      case ButtonType.outline:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        );
      case ButtonType.ghost:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        );
    }
  }

  Color _getTextColor() {
    switch (type) {
      case ButtonType.primary:
        return AppColors.whiteColor;
      case ButtonType.secondary:
        return AppColors.clr606060;
      case ButtonType.outline:
        return AppColors.primaryColor;
      case ButtonType.ghost:
        return AppColors.clr606060;
    }
  }
}

enum ButtonType {
  primary,
  secondary,
  outline,
  ghost,
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText({
    Key? key,
    required this.text,
    required this.style,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final int value;
  final TextStyle? style;
  final Duration duration;

  const AnimatedCounter({
    Key? key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  _AnimatedCounterState createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(
      begin: 0,
      end: widget.value.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ))..addListener(() {
        setState(() {
          _currentValue = _animation.value.round();
        });
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentValue.toString(),
      style: widget.style,
    );
  }
}

// Custom Page Route with Animations
class SlidePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;
  final Offset direction;

  SlidePageRoute({
    required this.child,
    this.direction = const Offset(1.0, 0.0),
  }) : super(
          transitionDuration: Duration(milliseconds: 300),
          pageBuilder: (context, animation, _) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: direction,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOutCubic,
      )),
      child: child,
    );
  }
}

// Usage Examples for the Modern Components:

/*
// Modern Button Usage:
ModernButton(
  text: 'Start Test',
  icon: Icons.play_arrow,
  onPressed: () => controller.startTest(),
  type: ButtonType.primary,
  width: double.infinity,
)

// Modern Card Usage:
ModernCard(
  child: Column(
    children: [
      Text('Card Content'),
      // More widgets...
    ],
  ),
  padding: EdgeInsets.all(24),
)

// Gradient Text Usage:
GradientText(
  text: 'Mock Test',
  style: TextStyleCustom.headingStyle(fontSize: 28),
  gradient: AppColors.linearButtonColor,
)

// Animated Counter Usage:
AnimatedCounter(
  value: result.correctAnswers,
  style: TextStyleCustom.headingStyle(fontSize: 48),
  duration: Duration(milliseconds: 1500),
)

// Custom Page Navigation:
Navigator.push(
  context,
  SlidePageRoute(
    child: TestScreen(),
    direction: Offset(1.0, 0.0), // Slide from right
  ),
);
*/
                        