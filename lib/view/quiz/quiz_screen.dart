import 'package:education/core/constants/color.dart';
import 'package:education/core/constants/font_style.dart';
import 'package:education/view/quiz/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamSelectionScreen extends StatelessWidget {
  final String? title;
  ExamSelectionScreen({Key? key, this.title}) : super(key: key);

  final List<ExamModel> exams = [
    ExamModel(
      id: 'upsc',
      name: 'UPSC',
      description: 'Union Public Service Commission',
      subjects: const [
        'General Studies',
        'Current Affairs',
        'History',
        'Geography',
      ],
      icon: '🏛️',
    ),
    ExamModel(
      id: 'bpsc',
      name: 'BPSC',
      description: 'Bihar Public Service Commission',
      subjects: const ['General Studies', 'Bihar GK', 'Current Affairs'],
      icon: '🏢',
    ),
    ExamModel(
      id: 'ssc',
      name: 'SSC',
      description: 'Staff Selection Commission',
      subjects: const ['Quantitative Aptitude', 'Reasoning', 'English', 'GK'],
      icon: '📊',
    ),
    ExamModel(
      id: 'railway',
      name: 'Railway',
      description: 'Railway Recruitment Board',
      subjects: const [
        'Mathematics',
        'General Intelligence',
        'General Awareness',
      ],
      icon: '🚂',
    ),
    ExamModel(
      id: 'banking',
      name: 'Banking',
      description: 'Bank PO/Clerk Exams',
      subjects: const [
        'Quantitative Aptitude',
        'Reasoning',
        'English',
        'Banking Awareness',
      ],
      icon: '🏦',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title ?? 'Select Exam',
          style: TextStyleCustom.headingStyle(
            fontSize: 20,
            color: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.whiteColor,
              AppColors.clrD1DEE8.withOpacity(0.3),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose your exam category',
                style: TextStyleCustom.headingStyle(
                  fontSize: 24,
                  color: AppColors.clr222222,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the government exam you want to prepare for',
                style: TextStyleCustom.normalStyle(
                  fontSize: 16,
                  color: AppColors.clr606060,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: exams.length,
                  itemBuilder: (context, index) {
                    final exam = exams[index];
                    return _ExamCard(exam: exam);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExamCard extends StatelessWidget {
  final ExamModel exam;

  const _ExamCard({required this.exam});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => Get.to(() => LanguageSelectionScreen(exam: exam)),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(exam.icon, style: const TextStyle(fontSize: 24)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exam.name,
                      style: TextStyleCustom.headingStyle(
                        fontSize: 18,
                        color: AppColors.clr222222,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exam.description,
                      style: TextStyleCustom.normalStyle(
                        fontSize: 14,
                        color: AppColors.clr606060,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children:
                          exam.subjects.take(2).map((subject) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                subject,
                                style: TextStyleCustom.normalStyle(
                                  fontSize: 11,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.clr8D8D8D,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageSelectionScreen extends StatelessWidget {
  final ExamModel exam;

  const LanguageSelectionScreen({Key? key, required this.exam})
    : super(key: key);

  static const List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'hi', 'name': 'हिंदी', 'flag': '🇮🇳'},
    {'code': 'bn', 'name': 'বাংলা', 'flag': '🇧🇩'},
    {'code': 'te', 'name': 'తెలుగు', 'flag': '🏁'},
    {'code': 'ta', 'name': 'தமிழ்', 'flag': '🏁'},
    {'code': 'mr', 'name': 'मराठी', 'flag': '🏁'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Language',
          style: TextStyleCustom.headingStyle(
            fontSize: 20,
            color: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.whiteColor,
              AppColors.clrD1DEE8.withOpacity(0.3),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose your preferred language',
                style: TextStyleCustom.headingStyle(
                  fontSize: 24,
                  color: AppColors.clr222222,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Questions will be generated in the selected language',
                style: TextStyleCustom.normalStyle(
                  fontSize: 16,
                  color: AppColors.clr606060,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final language = languages[index];
                    return _LanguageCard(
                      language: language,
                      onTap:
                          () => Get.to(
                            () => QuestionCountScreen(
                              exam: exam,
                              language: language['name']!,
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
}

class _LanguageCard extends StatelessWidget {
  final Map<String, String> language;
  final VoidCallback onTap;

  const _LanguageCard({required this.language, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(language['flag']!, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(
              language['name']!,
              style: TextStyleCustom.headingStyle(
                fontSize: 16,
                color: AppColors.clr222222,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionCountScreen extends StatefulWidget {
  final ExamModel exam;
  final String language;

  const QuestionCountScreen({
    Key? key,
    required this.exam,
    required this.language,
  }) : super(key: key);

  @override
  State<QuestionCountScreen> createState() => _QuestionCountScreenState();
}

class _QuestionCountScreenState extends State<QuestionCountScreen> {
  int selectedQuestionCount = 10;
  int selectedTimeInMinutes = 15;

  static const List<int> questionOptions = [5, 10, 15, 20, 25, 30];
  static const List<int> timeOptions = [5, 10, 15, 20, 25, 30];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Settings',
          style: TextStyleCustom.headingStyle(
            fontSize: 20,
            color: AppColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.whiteColor,
                AppColors.clrD1DEE8.withOpacity(0.3),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _QuizSummaryCard(exam: widget.exam, language: widget.language),
                const SizedBox(height: 24),
                _QuestionCountSelector(
                  selectedCount: selectedQuestionCount,
                  onCountSelected: (count) {
                    setState(() {
                      selectedQuestionCount = count;
                      selectedTimeInMinutes = (count * 1.5).round();
                    });
                  },
                ),
                const SizedBox(height: 24),
                _TimeSelector(
                  selectedTime: selectedTimeInMinutes,
                  onTimeSelected: (time) {
                    setState(() {
                      selectedTimeInMinutes = time;
                    });
                  },
                ),
                const Spacer(),
                _StartQuizButton(
                  onPressed:
                      () => Get.to(
                        () => QuizScreen(
                          exam: widget.exam,
                          language: widget.language,
                          questionCount: selectedQuestionCount,
                          timeInMinutes: selectedTimeInMinutes,
                        ),
                      ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizSummaryCard extends StatelessWidget {
  final ExamModel exam;
  final String language;

  const _QuizSummaryCard({required this.exam, required this.language});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quiz Summary',
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.clr222222,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.school, color: AppColors.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Exam: ${exam.name}',
                style: TextStyleCustom.normalStyle(
                  fontSize: 14,
                  color: AppColors.clr606060,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.language, color: AppColors.primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                'Language: $language',
                style: TextStyleCustom.normalStyle(
                  fontSize: 14,
                  color: AppColors.clr606060,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuestionCountSelector extends StatelessWidget {
  final int selectedCount;
  final ValueChanged<int> onCountSelected;

  const _QuestionCountSelector({
    required this.selectedCount,
    required this.onCountSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Number of Questions',
          style: TextStyleCustom.headingStyle(
            fontSize: 18,
            color: AppColors.clr222222,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              _QuestionCountScreenState.questionOptions.map((count) {
                return _SelectionChip(
                  label: count.toString(),
                  isSelected: selectedCount == count,
                  onTap: () => onCountSelected(count),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class _TimeSelector extends StatelessWidget {
  final int selectedTime;
  final ValueChanged<int> onTimeSelected;

  const _TimeSelector({
    required this.selectedTime,
    required this.onTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Time Duration (Minutes)',
          style: TextStyleCustom.headingStyle(
            fontSize: 18,
            color: AppColors.clr222222,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children:
              _QuestionCountScreenState.timeOptions.map((time) {
                return _SelectionChip(
                  label: '$time min',
                  isSelected: selectedTime == time,
                  onTap: () => onTimeSelected(time),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class _SelectionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _SelectionChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.clrC8C7CC,
          ),
          boxShadow:
              isSelected
                  ? [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : [],
        ),
        child: Text(
          label,
          style: TextStyleCustom.normalStyle(
            fontSize: 14,
            color: isSelected ? AppColors.whiteColor : AppColors.clr606060,
          ),
        ),
      ),
    );
  }
}

class _StartQuizButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _StartQuizButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.linearButtonColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Text(
            'Start Quiz',
            style: TextStyleCustom.headingStyle(
              fontSize: 16,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}

class QuizScreen extends StatelessWidget {
  final ExamModel exam;
  final String language;
  final int questionCount;
  final int timeInMinutes;

  const QuizScreen({
    Key? key,
    required this.exam,
    required this.language,
    required this.questionCount,
    required this.timeInMinutes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuizController>(
      init: QuizController(),
      builder: (controller) {
        // Initialize quiz when screen loads
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (controller.questions.isEmpty && !controller.isLoading.value) {
            controller.initializeQuiz(
              exam: exam.name,
              lang: language,
              questionsCount: questionCount,
              timeInMinutes: timeInMinutes,
            );
          }
        });

        return WillPopScope(
          onWillPop: () async {
            bool? result = await Get.dialog<bool>(
              AlertDialog(
                title: const Text('Exit Quiz'),
                content: const Text(
                  'Are you sure you want to exit the quiz? Your progress will be lost.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(result: false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Get.back(result: true),
                    child: const Text('Exit'),
                  ),
                ],
              ),
            );
            return result ?? false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                '${exam.name} Quiz',
                style: TextStyleCustom.headingStyle(
                  fontSize: 20,
                  color: AppColors.blackColor,
                ),
              ),
              centerTitle: true,
              actions: [
                Obx(
                  () => Container(
                    margin: const EdgeInsets.only(right: 16),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer,
                          size: 16,
                          color: AppColors.whiteColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          controller.formattedTime,
                          style: TextStyleCustom.normalStyle(
                            fontSize: 14,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: Obx(() {
              if (controller.isLoading.value) {
                return const _LoadingWidget();
              }

              if (controller.hasError.value) {
                return _ErrorWidget(
                  message: controller.errorMessage.value,
                  onRetry: controller.retryQuiz,
                );
              }

              if (controller.questions.isEmpty) {
                return _ErrorWidget(
                  message: 'No questions available',
                  onRetry: controller.retryQuiz,
                );
              }

              final currentQuestion =
                  controller.questions[controller.currentQuestionIndex.value];

              return _QuizBody(
                controller: controller,
                currentQuestion: currentQuestion,
              );
            }),
          ),
        );
      },
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
          ),
          const SizedBox(height: 20),
          Text(
            'Generating Questions...',
            style: TextStyleCustom.normalStyle(
              fontSize: 16,
              color: AppColors.clr606060,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: AppColors.clrFF3B30),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: TextStyleCustom.headingStyle(
                fontSize: 18,
                color: AppColors.clr222222,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyleCustom.normalStyle(
                fontSize: 14,
                color: AppColors.clr606060,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuizBody extends StatelessWidget {
  final QuizController controller;
  final QuestionModel currentQuestion;

  const _QuizBody({required this.controller, required this.currentQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.whiteColor, AppColors.clrD1DEE8.withOpacity(0.3)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProgressBar(controller: controller),
            const SizedBox(height: 16),
            _QuestionCounter(controller: controller),
            const SizedBox(height: 24),
            _QuestionCard(question: currentQuestion.question),
            const SizedBox(height: 24),
            Expanded(
              child: _OptionsListView(
                options: currentQuestion.options,
                controller: controller,
              ),
            ),
            _NextButton(controller: controller),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ProgressBar extends StatelessWidget {
  final QuizController controller;

  const _ProgressBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: 8,
        decoration: BoxDecoration(
          color: AppColors.clrC8C7CC,
          borderRadius: BorderRadius.circular(4),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: controller.progressPercentage,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.linearButtonColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuestionCounter extends StatelessWidget {
  final QuizController controller;

  const _QuestionCounter({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        'Question ${controller.currentQuestionIndex.value + 1} of ${controller.questions.length}',
        style: TextStyleCustom.normalStyle(
          fontSize: 14,
          color: AppColors.clr606060,
        ),
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final String question;

  const _QuestionCard({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        question,
        style: TextStyleCustom.headingStyle(
          fontSize: 18,
          color: AppColors.clr222222,
        ),
      ),
    );
  }
}

class _OptionsListView extends StatelessWidget {
  final List<String> options;
  final QuizController controller;

  const _OptionsListView({required this.options, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: options.length,
      itemBuilder: (context, index) {
        return Obx(() {
          bool isSelected = controller.selectedAnswer.value == index;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: _OptionTile(
              option: options[index],
              index: index,
              isSelected: isSelected,
              onTap: () => controller.selectAnswer(index),
            ),
          );
        });
      },
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String option;
  final int index;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.option,
    required this.index,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.clrC8C7CC,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      isSelected ? AppColors.primaryColor : AppColors.clrC8C7CC,
                  width: 2,
                ),
              ),
              child:
                  isSelected
                      ? Icon(Icons.check, size: 16, color: AppColors.whiteColor)
                      : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${String.fromCharCode(65 + index)}. $option',
                style: TextStyleCustom.normalStyle(
                  fontSize: 16,
                  color:
                      isSelected ? AppColors.primaryColor : AppColors.clr222222,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  final QuizController controller;

  const _NextButton({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool canProceed = controller.canProceed;

      return SizedBox(
        width: double.infinity,
        height: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient:
                canProceed
                    ? AppColors.linearButtonColor
                    : AppColors.inActiveButtonGradientColor,
            borderRadius: BorderRadius.circular(25),
            boxShadow:
                canProceed
                    ? [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                    : [],
          ),
          child: ElevatedButton(
            onPressed: canProceed ? controller.nextQuestion : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              controller.nextButtonText,
              style: TextStyleCustom.headingStyle(
                fontSize: 16,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizController controller = Get.find<QuizController>();

    double percentage =
        (controller.score.value / controller.questions.length) * 100;
    String grade =
        percentage >= 80
            ? 'Excellent'
            : percentage >= 60
            ? 'Good'
            : percentage >= 40
            ? 'Average'
            : 'Needs Improvement';

    Color gradeColor =
        percentage >= 80
            ? Colors.green
            : percentage >= 60
            ? AppColors.primaryColor
            : percentage >= 40
            ? Colors.orange
            : AppColors.clrE53935;

    return WillPopScope(
      onWillPop: () async {
        Get.offAll(() => ExamSelectionScreen());
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Quiz Results',
            style: TextStyleCustom.headingStyle(
              fontSize: 20,
              color: AppColors.blackColor,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.whiteColor,
                AppColors.clrD1DEE8.withOpacity(0.3),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                _ScoreCard(
                  controller: controller,
                  percentage: percentage,
                  grade: grade,
                  gradeColor: gradeColor,
                ),
                const SizedBox(height: 24),
                _StatsCard(controller: controller, percentage: percentage),
                const SizedBox(height: 24),
                _ActionButtons(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final QuizController controller;
  final double percentage;
  final String grade;
  final Color gradeColor;

  const _ScoreCard({
    required this.controller,
    required this.percentage,
    required this.grade,
    required this.gradeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: gradeColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              percentage >= 60 ? Icons.emoji_events : Icons.sentiment_neutral,
              size: 40,
              color: gradeColor,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Quiz Completed!',
            style: TextStyleCustom.headingStyle(
              fontSize: 24,
              color: AppColors.clr222222,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            grade,
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: gradeColor,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  gradeColor.withOpacity(0.2),
                  gradeColor.withOpacity(0.1),
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${controller.score.value}/${controller.questions.length}',
                    style: TextStyleCustom.headingStyle(
                      fontSize: 24,
                      color: gradeColor,
                    ),
                  ),
                  Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyleCustom.normalStyle(
                      fontSize: 16,
                      color: gradeColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  final QuizController controller;
  final double percentage;

  const _StatsCard({required this.controller, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quiz Statistics',
            style: TextStyleCustom.headingStyle(
              fontSize: 18,
              color: AppColors.clr222222,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Correct',
                  '${controller.score.value}',
                  Colors.green,
                  Icons.check_circle,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'Incorrect',
                  '${controller.questions.length - controller.score.value}',
                  AppColors.clrE53935,
                  Icons.cancel,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  'Total Questions',
                  '${controller.questions.length}',
                  AppColors.primaryColor,
                  Icons.quiz,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  'Time Taken',
                  '${(controller.totalTime - controller.timeRemaining.value) ~/ 60} min',
                  AppColors.clr606060,
                  Icons.access_time,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String title,
    String value,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyleCustom.headingStyle(fontSize: 18, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyleCustom.normalStyle(
              fontSize: 12,
              color: AppColors.clr606060,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: () => Get.to(() => ExamSelectionScreen()),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Home',
                style: TextStyleCustom.headingStyle(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ),
        // const SizedBox(width: 16),
        // Expanded(
        //   child: SizedBox(
        //     height: 50,
        //     child: DecoratedBox(
        //       decoration: BoxDecoration(
        //         gradient: AppColors.linearButtonColor,
        //         borderRadius: BorderRadius.circular(25),
        //         boxShadow: [
        //           BoxShadow(
        //             color: AppColors.primaryColor.withOpacity(0.3),
        //             blurRadius: 8,
        //             offset: const Offset(0, 4),
        //           ),
        //         ],
        //       ),
        //       child: ElevatedButton(
        //         onPressed: () {
        //           // Navigate back to quiz settings
        //           Get.back();
        //           Get.back();
        //           Get.back();
        //         },
        //         style: ElevatedButton.styleFrom(
        //           backgroundColor: Colors.transparent,
        //           shadowColor: Colors.transparent,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(25),
        //           ),
        //         ),
        //         child: Text(
        //           'Retake Quiz',
        //           style: TextStyleCustom.headingStyle(
        //             fontSize: 16,
        //             color: AppColors.whiteColor,
        //           ),
        //         ),
        //       ),
        // ),
        // ),
        // ),
      ],
    );
  }
}
