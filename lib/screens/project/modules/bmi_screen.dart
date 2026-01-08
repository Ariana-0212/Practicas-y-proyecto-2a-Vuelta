import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/theme/app_theme.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/glass_card.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  double _height = 170;
  double _weight = 70;

  double get _bmi => _weight / ((_height / 100) * (_height / 100));

  String get _category {
    if (_bmi < 18.5) return 'Bajo peso';
    if (_bmi < 25) return 'Normal';
    if (_bmi < 30) return 'Sobrepeso';
    return 'Obesidad';
  }

  Color get _categoryColor {
    if (_bmi < 18.5) return Colors.blueAccent;
    if (_bmi < 25) return Colors.greenAccent;
    if (_bmi < 30) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Calculadora IMC'),
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInDown(
                          child: GlassCard(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              children: [
                                const Text(
                                  'Tu IMC',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  _bmi.toStringAsFixed(1),
                                  style: TextStyle(
                                    color: _categoryColor,
                                    fontSize: 64,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  _category,
                                  style: TextStyle(
                                    color: _categoryColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GlassCard(
                  child: Column(
                    children: [
                      _buildSlider(
                        'Altura',
                        _height,
                        100,
                        220,
                        (v) => setState(() => _height = v),
                        'cm',
                      ),
                      const SizedBox(height: 20),
                      _buildSlider(
                        'Peso',
                        _weight,
                        40,
                        150,
                        (v) => setState(() => _weight = v),
                        'kg',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
    String unit,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white70)),
            Text(
              '${value.toStringAsFixed(0)} $unit',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppTheme.electricBlue,
            inactiveTrackColor: Colors.white10,
            thumbColor: AppTheme.neonPurple,
            overlayColor: AppTheme.neonPurple.withOpacity(0.2),
          ),
          child: Slider(value: value, min: min, max: max, onChanged: onChanged),
        ),
      ],
    );
  }
}
