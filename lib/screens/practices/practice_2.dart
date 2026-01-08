import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/theme/app_theme.dart';
import 'package:segundavuelta/widgets/animated_button.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/glass_card.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class Practice2Screen extends StatefulWidget {
  const Practice2Screen({super.key});

  @override
  State<Practice2Screen> createState() => _Practice2ScreenState();
}

class _Practice2ScreenState extends State<Practice2Screen> {
  final List<String> _messages = [];
  static const int _maxMessages = 10;

  void _addMessage() {
    if (_messages.length < _maxMessages) {
      setState(() {
        _messages.add("Hola Mundo");
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Max limit reached (10)"),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _reset() {
    setState(() {
      _messages.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Práctica 2: Generador Hola Mundo',
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _reset,
          ),
        ],
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Controls
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Contador",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "${_messages.length} / $_maxMessages",
                            style: TextStyle(
                              color: _messages.length == _maxMessages
                                  ? Colors.redAccent
                                  : AppTheme.electricBlue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      AnimatedButton(
                        text: 'Imprimir "Hola"',
                        icon: Icons.print,
                        color: _messages.length == _maxMessages
                            ? Colors.grey
                            : AppTheme.neonPurple,
                        onTap: _addMessage,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // List Display
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return FadeInLeft(
                      duration: const Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: AppTheme.electricBlue,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                _messages[index],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
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
}
