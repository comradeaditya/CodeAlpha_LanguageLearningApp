import 'package:flutter/material.dart';
import 'dart:math';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  String _selectedCategory = 'Basic Words';
  bool _isFront = true;
  late AnimationController _controller;
  late Animation<double> _animation;

  final Map<String, List<Map<String, String>>> _allCards = {
    'Basic Words': [
      {'word': 'Hola', 'translation': 'Hello'},
      {'word': 'Gracias', 'translation': 'Thank you'},
      {'word': 'Por favor', 'translation': 'Please'},
      {'word': 'Sí', 'translation': 'Yes'},
      {'word': 'Adiós', 'translation': 'Goodbye'},
      {'word': 'Buenos días', 'translation': 'Good morning'},
    ],
    'Food & Drinks': [
      {'word': 'Agua', 'translation': 'Water'},
      {'word': 'Pan', 'translation': 'Bread'},
      {'word': 'Leche', 'translation': 'Milk'},
      {'word': 'Manzana', 'translation': 'Apple'},
      {'word': 'Café', 'translation': 'Coffee'},
      {'word': 'Arroz', 'translation': 'Rice'},
    ],
    'Colors': [
      {'word': 'Rojo', 'translation': 'Red'},
      {'word': 'Azul', 'translation': 'Blue'},
      {'word': 'Verde', 'translation': 'Green'},
      {'word': 'Amarillo', 'translation': 'Yellow'},
      {'word': 'Negro', 'translation': 'Black'},
      {'word': 'Blanco', 'translation': 'White'},
    ],
    'Numbers': [
      {'word': 'Uno', 'translation': 'One'},
      {'word': 'Dos', 'translation': 'Two'},
      {'word': 'Tres', 'translation': 'Three'},
      {'word': 'Cuatro', 'translation': 'Four'},
      {'word': 'Cinco', 'translation': 'Five'},
      {'word': 'Seis', 'translation': 'Six'},
    ],
  };

  List<Map<String, String>> get _currentCards =>
      _allCards[_selectedCategory] ?? [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.isAnimating) return;
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() => _isFront = !_isFront);
  }

  void _nextCard() {
    _controller.reset();
    setState(() {
      _isFront = true;
      if (_currentIndex < _currentCards.length - 1) {
        _currentIndex++;
      }
    });
  }

  void _previousCard() {
    _controller.reset();
    setState(() {
      _isFront = true;
      if (_currentIndex > 0) {
        _currentIndex--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = _currentCards[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        title: const Text(
          'Flashcards',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Category Selector
            SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: _allCards.keys.map((category) {
                  final isSelected = category == _selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      _controller.reset();
                      setState(() {
                        _selectedCategory = category;
                        _currentIndex = 0;
                        _isFront = true;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF6C63FF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),

            // Card Counter
            Text(
              '${_currentIndex + 1} / ${_currentCards.length}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              _isFront ? 'Tap card to see translation' : 'Tap card to flip back',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),

            const SizedBox(height: 20),

            // Animated Flip Card
            GestureDetector(
              onTap: _flipCard,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final angle = _animation.value * pi;
                  final isShowingFront = angle < pi / 2;

                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(angle),
                    child: isShowingFront
                        ? _buildCardFace(
                            label: 'Spanish',
                            text: card['word']!,
                            color: const Color(0xFF6C63FF),
                          )
                        : Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()..rotateY(pi),
                            child: _buildCardFace(
                              label: 'English',
                              text: card['translation']!,
                              color: const Color(0xFF4CAF50),
                            ),
                          ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentIndex > 0 ? _previousCard : null,
                  icon: const Icon(Icons.arrow_back_ios),
                  label: const Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _currentIndex < _currentCards.length - 1
                      ? _nextCard
                      : null,
                  icon: const Icon(Icons.arrow_forward_ios),
                  label: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardFace({
    required String label,
    required String text,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}