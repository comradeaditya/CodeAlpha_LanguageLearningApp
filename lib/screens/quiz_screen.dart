import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedOption;
  bool _answered = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What does "Hola" mean?',
      'correct': 'Hello',
      'options': ['Goodbye', 'Hello', 'Thank you', 'Please'],
    },
    {
      'question': 'What does "Gracias" mean?',
      'correct': 'Thank you',
      'options': ['Sorry', 'Please', 'Thank you', 'Welcome'],
    },
    {
      'question': 'What does "Agua" mean?',
      'correct': 'Water',
      'options': ['Milk', 'Juice', 'Coffee', 'Water'],
    },
    {
      'question': 'What does "Rojo" mean?',
      'correct': 'Red',
      'options': ['Blue', 'Green', 'Red', 'Yellow'],
    },
    {
      'question': 'What does "Uno" mean?',
      'correct': 'One',
      'options': ['Two', 'Three', 'One', 'Four'],
    },
    {
      'question': 'What does "Madre" mean?',
      'correct': 'Mother',
      'options': ['Sister', 'Mother', 'Father', 'Brother'],
    },
    {
      'question': 'What does "Pan" mean?',
      'correct': 'Bread',
      'options': ['Rice', 'Bread', 'Milk', 'Apple'],
    },
    {
      'question': 'What does "Azul" mean?',
      'correct': 'Blue',
      'options': ['Red', 'Blue', 'Green', 'Black'],
    },
    {
      'question': 'What does "Cinco" mean?',
      'correct': 'Five',
      'options': ['Three', 'Four', 'Six', 'Five'],
    },
    {
      'question': 'What does "Adiós" mean?',
      'correct': 'Goodbye',
      'options': ['Hello', 'Goodbye', 'Please', 'Yes'],
    },
  ];

  void _selectOption(int index) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
      if (_questions[_currentIndex]['options'][index] ==
          _questions[_currentIndex]['correct']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex++;
        _selectedOption = null;
        _answered = false;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Quiz Completed!',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_score / ${_questions.length}',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6C63FF),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              _score >= 8
                  ? 'Excellent!'
                  : _score >= 5
                      ? 'Good Job!'
                      : 'Keep Practicing!',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _score = 0;
                _selectedOption = null;
                _answered = false;
              });
            },
            child: const Text(
              'Try Again',
              style: TextStyle(color: Color(0xFF6C63FF)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }

  Color _getOptionColor(int index) {
    if (!_answered) return Colors.white;
    final isCorrect = _questions[_currentIndex]['options'][index] ==
        _questions[_currentIndex]['correct'];
    if (index == _selectedOption) {
      return isCorrect
          ? const Color(0xFF4CAF50)
          : const Color(0xFFE53935);
    }
    if (isCorrect) return const Color(0xFF4CAF50);
    return Colors.white;
  }

  Color _getOptionTextColor(int index) {
    if (!_answered) return Colors.black87;
    final isCorrect = _questions[_currentIndex]['options'][index] ==
        _questions[_currentIndex]['correct'];
    if (index == _selectedOption || isCorrect) return Colors.white;
    return Colors.black87;
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        title: const Text(
          'Quiz',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                'Score: $_score',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Bar
            Row(
              children: [
                Text(
                  'Question ${_currentIndex + 1}/${_questions.length}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(_score / _questions.length * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Color(0xFF6C63FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF6C63FF),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Question Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Text(
                question['question'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Choose the correct answer:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 12),

            // Options
            ...List.generate(4, (index) {
              return GestureDetector(
                onTap: () => _selectOption(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _getOptionColor(index),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: Border.all(
                      color: !_answered
                          ? Colors.grey.shade200
                          : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: !_answered
                              ? const Color(0xFF6C63FF).withValues(alpha: 0.1)
                              : Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            ['A', 'B', 'C', 'D'][index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _getOptionTextColor(index),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        question['options'][index],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _getOptionTextColor(index),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const Spacer(),

            // Next Button
            if (_answered)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    _currentIndex < _questions.length - 1
                        ? 'Next Question →'
                        : 'See Results',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}