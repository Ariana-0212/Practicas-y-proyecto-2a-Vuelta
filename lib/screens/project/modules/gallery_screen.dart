import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/glass_card.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  // Now using real local assets
  final List<String> _images = const [
    'assets/images/image1.png',
    'assets/images/image2.png',
    // Add more here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Galería'),
      body: GradientBackground(
        child: SafeArea(
          child: _images.isEmpty
              ? const Center(
                  child: Text(
                    "No hay imágenes en assets/images/",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: _images.length, // Dynamic based on list
                  itemBuilder: (context, index) {
                    return FadeInUp(
                      delay: Duration(milliseconds: 100 * index),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => _FullScreenImage(
                                tag: 'img_$index',
                                imagePath: _images[index],
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: Hero(
                          tag: 'img_$index',
                          child: GlassCard(
                            padding: EdgeInsets.zero,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(_images[index]),
                                  fit: BoxFit.cover,
                                  onError: (exception, stackTrace) {
                                    // Fallback if image not found
                                  },
                                ),
                              ),
                              child: Container(
                                // Overlay to show text if image missing or just for style
                                alignment: Alignment.bottomCenter,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  'Imagen ${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
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

class _FullScreenImage extends StatelessWidget {
  final String tag;
  final String imagePath;
  final int index;

  const _FullScreenImage({
    required this.tag,
    required this.imagePath,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: tag,
            child: InteractiveViewer(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.white54,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "No se encontró $imagePath",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
