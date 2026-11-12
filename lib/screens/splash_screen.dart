import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onFinished});

  final VoidCallback onFinished;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;

  static const Color forest = Color(0xFF146B50);
  static const Color deepForest = Color(0xFF0D4938);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.82,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) widget.onFinished();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [forest, deepForest],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -90,
              right: -75,
              child: _decorationCircle(260),
            ),
            Positioned(
              bottom: -115,
              left: -80,
              child: _decorationCircle(290),
            ),
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 112,
                        height: 112,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(34),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 28,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.travel_explore_rounded,
                          size: 62,
                          color: forest,
                        ),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'TemuKembali',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 31,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.7,
                        ),
                      ),
                      const SizedBox(height: 9),
                      const Text(
                        'Temukan. Hubungkan. Kembali.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFD9F0E3),
                          fontSize: 13,
                          letterSpacing: 0.35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 42,
              child: Column(
                children: [
                  const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFFD9F0E3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 13),
                  Text(
                    'Mempersiapkan pengalaman terbaik untukmu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.72),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _decorationCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.07),
          width: 1.5,
        ),
      ),
    );
  }
}
