import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/theme/app_theme.dart';
import 'package:segundavuelta/widgets/animated_button.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/glass_card.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class ParityScreen extends StatefulWidget {
  const ParityScreen({super.key});

  @override
  State<ParityScreen> createState() => _ParityScreenState();
}

enum ParityChoice { par, impar }

class _ParityScreenState extends State<ParityScreen> {
  int _userScore = 0;
  int _cpuScore = 0;

  ParityChoice _selectedParity = ParityChoice.par;
  int _selectedNumber = 0; // 0-5

  String _lastResultText = "¿Listo para jugar?";

  void _playRound() {
    // 1. CPU generates random number 0-5
    final int cpuNumber = Random().nextInt(6); // 0 to 5

    // 2. Sum
    final int sum = _selectedNumber + cpuNumber;
    final bool isSumPar = sum % 2 == 0;

    // 3. Determine Winner
    final bool userWins =
        (isSumPar && _selectedParity == ParityChoice.par) ||
        (!isSumPar && _selectedParity == ParityChoice.impar);

    setState(() {
      if (userWins) {
        _userScore++;
        _lastResultText = "¡Ganaste! (CPU: $cpuNumber, Suma: $sum)";
      } else {
        _cpuScore++;
        _lastResultText = "¡CPU Gana! (CPU: $cpuNumber, Suma: $sum)";
      }
    });

    // 4. Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          userWins
              ? '¡GANASTE! $_selectedNumber + $cpuNumber = $sum (${isSumPar ? "Par" : "Impar"})'
              : '¡CPU GANA! $_selectedNumber + $cpuNumber = $sum (${isSumPar ? "Par" : "Impar"})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: userWins ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _resetGame() {
    setState(() {
      _userScore = 0;
      _cpuScore = 0;
      _lastResultText = "Juego Reiniciado";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Juego de Paridad (Usuario vs CPU)'),
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Score Board
                FadeInDown(
                  child: GlassCard(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildScoreColumn("Tú", _userScore),
                        const Text(
                          "VS",
                          style: TextStyle(
                            color: Colors.white24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildScoreColumn("CPU", _cpuScore),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Parity Selection
                FadeInUp(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "1. Choose Parity:",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 10),
                      SegmentedButton<ParityChoice>(
                        segments: const [
                          ButtonSegment(
                            value: ParityChoice.par,
                            label: Text('PAR (Even)'),
                            icon: Icon(Icons.numbers),
                          ),
                          ButtonSegment(
                            value: ParityChoice.impar,
                            label: Text('IMPAR (Odd)'),
                            icon: Icon(Icons.circle_outlined),
                          ),
                        ],
                        selected: {_selectedParity},
                        onSelectionChanged: (Set<ParityChoice> newSelection) {
                          setState(() {
                            _selectedParity = newSelection.first;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.resolveWith((
                            states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return AppTheme.electricBlue;
                            }
                            return Colors.white10;
                          }),
                          foregroundColor: WidgetStateProperty.all(
                            Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Number Selection
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "2. Elige Número (0-5):",
                        style: TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.center,
                        children: List.generate(6, (index) {
                          final bool isSelected = _selectedNumber == index;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedNumber = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.neonPurple
                                    : Colors.white10,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white24,
                                  width: 2,
                                ),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.neonPurple
                                              .withOpacity(0.5),
                                          blurRadius: 10,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Center(
                                child: Text(
                                  "$index",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Play Button
                FadeInUp(
                  delay: const Duration(milliseconds: 400),
                  child: AnimatedButton(
                    text: 'JUGAR RONDA',
                    icon: Icons.play_arrow,
                    onTap: _playRound, // Logic executes here
                    color: AppTheme.electricBlue,
                  ),
                ),

                const SizedBox(height: 20),
                Text(
                  _lastResultText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white54,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 40),

                // Reset Button
                OutlinedButton.icon(
                  onPressed: _resetGame,
                  icon: const Icon(Icons.refresh),
                  label: const Text("Reiniciar Juego"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreColumn(String label, int score) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 5),
        Text(
          "$score",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
