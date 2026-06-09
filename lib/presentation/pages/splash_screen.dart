import 'package:bingo_ticketing_system_mobile/data/services/auth_storage.dart';
import 'package:bingo_ticketing_system_mobile/presentation/pages/home_screen.dart';
import 'package:bingo_ticketing_system_mobile/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  Future<void> _handleNavigation(LottieComposition composition) async {
    _controller.duration = composition.duration;
    await _controller.forward();

    final minimumDelay = Future.delayed(const Duration(seconds: 2));
    await minimumDelay;

    final storage = AuthStorage();
    final token = await storage.getAccessToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const Loginscreen()));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: content());
  }

  Widget content() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Lottie.asset(
          'assets/splash.json',
          controller: _controller,
          fit: BoxFit.contain,
          onLoaded: (composition) {
            _handleNavigation(composition);
          },
        ),
      ),
    );
  }
}
