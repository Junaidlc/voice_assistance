import 'package:flutter/material.dart';
import 'package:voice_assistance/widgets/pallete.dart';

class FutureBox extends StatelessWidget {
  final Color color;
  final String hearder;
  final String description;
  const FutureBox({
    super.key,
    required this.color,
    required this.hearder,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(left: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                hearder,
                style: const TextStyle(
                    fontFamily: 'Cera Pro',
                    color: Pallete.mainFontColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                description,
                style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
