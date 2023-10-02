import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String question;
  final int questionIndex;
  const QuestionWidget({
    Key? key,
    required this.question,
    required this.questionIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final widgetHeight = (screenWidth / 16 * 9) + 64;
    return SizedBox(
      width: screenWidth,
      height: widgetHeight,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              // top and bottom are half the height of next two widgets
              margin: const EdgeInsets.only(top: 16, bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            // UnconstrainedBox: to avoid filling the width and to consider only childs width
            child: UnconstrainedBox(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    '${questionIndex + 1} / 10',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: UnconstrainedBox(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
