import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      'title': 'Basic Words',
      'subtitle': '20 words',
      'icon': Icons.abc,
      'color': Color(0xFF6C63FF),
      'words': [
        {'word': 'Hola', 'translation': 'Hello'},
        {'word': 'Gracias', 'translation': 'Thank you'},
        {'word': 'Por favor', 'translation': 'Please'},
        {'word': 'Sí', 'translation': 'Yes'},
        {'word': 'No', 'translation': 'No'},
        {'word': 'Adiós', 'translation': 'Goodbye'},
        {'word': 'Buenos días', 'translation': 'Good morning'},
        {'word': 'Buenas noches', 'translation': 'Good night'},
      ],
    },
    {
      'title': 'Food & Drinks',
      'subtitle': '15 words',
      'icon': Icons.restaurant,
      'color': Color(0xFFFF9800),
      'words': [
        {'word': 'Agua', 'translation': 'Water'},
        {'word': 'Pan', 'translation': 'Bread'},
        {'word': 'Leche', 'translation': 'Milk'},
        {'word': 'Manzana', 'translation': 'Apple'},
        {'word': 'Pollo', 'translation': 'Chicken'},
        {'word': 'Arroz', 'translation': 'Rice'},
        {'word': 'Café', 'translation': 'Coffee'},
        {'word': 'Jugo', 'translation': 'Juice'},
      ],
    },
    {
      'title': 'Colors',
      'subtitle': '10 words',
      'icon': Icons.palette,
      'color': Color(0xFFE91E63),
      'words': [
        {'word': 'Rojo', 'translation': 'Red'},
        {'word': 'Azul', 'translation': 'Blue'},
        {'word': 'Verde', 'translation': 'Green'},
        {'word': 'Amarillo', 'translation': 'Yellow'},
        {'word': 'Negro', 'translation': 'Black'},
        {'word': 'Blanco', 'translation': 'White'},
        {'word': 'Naranja', 'translation': 'Orange'},
        {'word': 'Morado', 'translation': 'Purple'},
      ],
    },
    {
      'title': 'Numbers',
      'subtitle': '10 words',
      'icon': Icons.numbers,
      'color': Color(0xFF4CAF50),
      'words': [
        {'word': 'Uno', 'translation': 'One'},
        {'word': 'Dos', 'translation': 'Two'},
        {'word': 'Tres', 'translation': 'Three'},
        {'word': 'Cuatro', 'translation': 'Four'},
        {'word': 'Cinco', 'translation': 'Five'},
        {'word': 'Seis', 'translation': 'Six'},
        {'word': 'Siete', 'translation': 'Seven'},
        {'word': 'Ocho', 'translation': 'Eight'},
      ],
    },
    {
      'title': 'Family',
      'subtitle': '12 words',
      'icon': Icons.family_restroom,
      'color': Color(0xFF2196F3),
      'words': [
        {'word': 'Madre', 'translation': 'Mother'},
        {'word': 'Padre', 'translation': 'Father'},
        {'word': 'Hermano', 'translation': 'Brother'},
        {'word': 'Hermana', 'translation': 'Sister'},
        {'word': 'Abuelo', 'translation': 'Grandfather'},
        {'word': 'Abuela', 'translation': 'Grandmother'},
        {'word': 'Hijo', 'translation': 'Son'},
        {'word': 'Hija', 'translation': 'Daughter'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        title: const Text(
          'Lessons',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🇪🇸 Spanish Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Select a category to start learning',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _buildCategoryCard(context, category);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      BuildContext context, Map<String, dynamic> category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WordListScreen(
              title: category['title'],
              words: category['words'],
              color: category['color'],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (category['color'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                category['icon'] as IconData,
                color: category['color'] as Color,
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category['subtitle'],
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: category['color'] as Color,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

// Word List Screen
class WordListScreen extends StatelessWidget {
  final String title;
  final List<Map<String, String>> words;
  final Color color;

  const WordListScreen({
    super.key,
    required this.title,
    required this.words,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: words.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  words[index]['word']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  words[index]['translation']!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}