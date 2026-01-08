import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/theme/app_theme.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/glass_card.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<String> _notes = [];
  final TextEditingController _controller = TextEditingController();

  void _addNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceDark.withOpacity(0.9),
        title: const Text('Nueva Nota', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Escribe tu nota...',
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppTheme.electricBlue),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                setState(() {
                  _notes.add(_controller.text);
                  _controller.clear();
                });
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Agregar',
              style: TextStyle(color: AppTheme.neonPurple),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  void _clearAll() {
    setState(() {
      _notes.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Notas',
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep, color: Colors.white),
            onPressed: _notes.isEmpty ? null : _clearAll,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        backgroundColor: AppTheme.neonPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: GradientBackground(
        child: SafeArea(
          child: _notes.isEmpty
              ? Center(
                  child: FadeIn(
                    child: const Text(
                      'Sin notas.\nToca + para agregar una.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 18),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _notes.length,
                  itemBuilder: (context, index) {
                    return FadeInLeft(
                      duration: const Duration(milliseconds: 300),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Dismissible(
                          key: Key(_notes[index] + index.toString()),
                          onDismissed: (_) => _deleteNote(index),
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            color: Colors.red.withOpacity(0.5),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: GlassCard(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              _notes[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
