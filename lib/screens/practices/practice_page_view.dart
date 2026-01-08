import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/screens/practices/practice_1.dart';
import 'package:segundavuelta/screens/practices/practice_2.dart';
import 'package:segundavuelta/screens/practices/practice_4.dart';
import 'package:segundavuelta/screens/practices/practice_5.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class Practice3PageView extends StatefulWidget {
  final int maxVisiblePractice;
  final int initialPage;

  const Practice3PageView({
    super.key,
    this.maxVisiblePractice = 5,
    this.initialPage = 0,
  });

  @override
  State<Practice3PageView> createState() => _Practice3PageViewState();
}

class _Practice3PageViewState extends State<Practice3PageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Determine pages based on rules
    final List<Widget> pages = [
      // Wrapped in SafeArea/Padding internally inside pageview or handled by widgets?
      // P1 and P2 have transparent backgrounds in their builds if we strip Scaffold?
      // Actually P1/P2 defined previously return Scaffold.
      // We should probably strip Scaffold for embedding or keep it?
      // If we keep Scaffold inside Scaffold (from PageView parent?), it might be okay but weird.
      // Better to have P1/P2/P4/P5 return just the body content if used here.
      // BUT: I already implemented P1/P2 returning Scaffold.
      // Solution: Wrap them in a helper that strips Scaffold or just use them.
      // Flutter PageView can hold Scaffolds. It's fine.
      const Practice1Screen(),
      const Practice2Screen(),
    ];

    if (widget.maxVisiblePractice >= 4) {
      // P4 and P5 are implemented as just content widgets (no Scaffold).
      // So we need to wrap them to look consistent, OR wrap P1/P2 to not have Scaffold?
      // P1/P2 have Scaffold+GradientBackground.
      // P4/P5 need Background.
      pages.add(
        const Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(title: 'Práctica 4: Formulario'),
          backgroundColor: Colors.transparent,
          body: GradientBackground(child: SafeArea(child: Practice4Screen())),
        ),
      );
    }

    if (widget.maxVisiblePractice >= 5) {
      pages.add(
        const Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(title: 'Práctica 5: PPT'),
          backgroundColor: Colors.transparent,
          body: GradientBackground(child: SafeArea(child: Practice5Screen())),
        ),
      );
    }

    // However, P1 and P2 have AppBars. P4/P5 don't have AppBars in my wrapper above.
    // Let's add AppBars to the wrapper or rely on the container?
    // The prompt implies a single container.
    // If I swipe, the AppBar should probably change or stay "Practice Container"?
    // Using individual Scaffolds is actually okay for a PageView, each page handles its own UI.
    // So for P4/P5 wrapper, let's add an AppBar too.

    // Better approach:
    // P3PageView is the Scaffold.
    // Pages are children.
    // But P1/P2 have their own Scaffold.
    // It's cleaner to use the individual Scaffolds inside the PageView.
    // So the wrapper for P4/P5 should be a Scaffold.

    // Let's update the P4/P5 list adding logic.

    // Wait, widget.maxVisiblePractice >= 4 adds P4.
    // P4 content is Practice4Screen.

    return PageView(
      controller: _pageController,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
        },
      ),
      children: pages,
    );
  }
}
