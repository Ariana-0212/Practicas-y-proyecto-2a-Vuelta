import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/theme/app_theme.dart';
import 'package:segundavuelta/widgets/glass_card.dart';

class Practice5Screen extends StatefulWidget {
  const Practice5Screen({super.key});

  @override
  State<Practice5Screen> createState() => _Practice5ScreenState();
}

class _Practice5ScreenState extends State<Practice5Screen> {
  String? _userChoice;
  String? _computerChoice;
  String _result = '¡Elige tu arma!';

  final List<String> _choices = ['Piedra', 'Papel', 'Tijera'];
  final Map<String, IconData> _icons = {
    'Piedra': Icons.landscape,
    'Papel': Icons.feed,
    'Tijera': Icons.content_cut,
  };

  void _play(String choice) {
    final computer = _choices[Random().nextInt(3)];
    String result;

    if (choice == computer) {
      result = "¡Empate!";
    } else if ((choice == 'Piedra' && computer == 'Tijera') ||
        (choice == 'Papel' && computer == 'Piedra') ||
        (choice == 'Tijera' && computer == 'Papel')) {
      result = "¡Ganaste!";
    } else {
      result = "¡La CPU Gana!";
    }

    setState(() {
      _userChoice = choice;
      _computerChoice = computer;
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            child: const Text(
              'Práctica 5: PPT',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30),
          GlassCard(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  _result,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.electricBlue,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPlayerColumn('Tú', _userChoice),
                    const Text(
                      'VS',
                      style: TextStyle(
                        color: Colors.white30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildPlayerColumn('CPU', _computerChoice),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _choices
                .map((choice) => _buildGameButton(choice))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerColumn(String label, String? choice) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 10),
        Icon(
          choice != null ? _icons[choice] : Icons.question_mark,
          size: 40,
          color: Colors.white,
        ),
        const SizedBox(height: 5),
        Text(choice ?? '-', style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildGameButton(String choice) {
    return GestureDetector(
      onTap: () => _play(choice),
      child: FadeInUp(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.glassBorder),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(_icons[choice], color: AppTheme.neonPurple),
              const SizedBox(height: 4),
              Text(
                choice,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
