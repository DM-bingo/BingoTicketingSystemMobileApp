import 'dart:math';
import 'package:flutter/material.dart';
import 'package:bingo_ticketing_system_mobile/core/constants/app_colors.dart';
import 'package:bingo_ticketing_system_mobile/presentation/pages/view_existing_tickets.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});
  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = [
    const ViewExistingTickets(),
    const Center(child: Text('Završeni Tiketi', style: optionStyle)),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    if (index == 1) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF7),
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Aktivni Tiketi' : 'Završeni Tiketi'),
        backgroundColor: Appcolors.green1,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: Appcolors.green1.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Appcolors.green1.withValues(alpha: 0.2),
                width: 0.5,
              ),
            ),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, _) {
                return CustomPaint(
                  painter: LiquidBubblePainter(
                    progress: _animation.value,
                    color: Appcolors.green1,
                  ),
                  child: Row(
                    children: [
                      _NavItem(
                        icon: Icons.home_outlined,
                        label: 'Aktivni',
                        isSelected: _selectedIndex == 0,
                        onTap: () => _onItemTapped(0),
                      ),
                      _NavItem(
                        icon: Icons.history,
                        label: 'Završeni',
                        isSelected: _selectedIndex == 1,
                        onTap: () => _onItemTapped(1),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class LiquidBubblePainter extends CustomPainter {
  final double progress;
  final Color color;

  LiquidBubblePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.82)
      ..style = PaintingStyle.fill;

    final double halfW = size.width / 2;
    final double h = size.height;
    final double pad = 5.0;
    final double r = (h / 2) - pad;

    // Pozicija centra bubble-a (lijevo=0.0, desno=1.0)
    final double cx = pad + r + progress * (halfW - pad * 2);

    // Liquid deformacija - bubble se razvlači tokom animacije
    // Na sredini (progress~0.5) bubble je najviše razvučen
    final double stretch = sin(progress * pi);
    final double rx = r + stretch * r * 0.55; // horizontalni radijus
    final double ry = r - stretch * r * 0.28; // vertikalni radijus (spljoštavanje)

    final double cy = h / 2;

    // Crtamo liquid blob sa cubic bezier krivama
    _drawLiquidBlob(canvas, paint, cx, cy, rx, ry, stretch);
  }

  void _drawLiquidBlob(Canvas canvas, Paint paint, double cx, double cy,
      double rx, double ry, double stretch) {
    // Kontrolne tačke za organic blob oblik
    final double wobble = stretch * ry * 0.3;

    final path = Path();

    // Koristimo 4 cubic bezier segmenta za blob
    // Gornja lijeva kriva
    path.moveTo(cx, cy - ry);
    path.cubicTo(
      cx + rx * 0.55, cy - ry + wobble,
      cx + rx, cy - ry * 0.55,
      cx + rx, cy,
    );
    // Donja desna kriva
    path.cubicTo(
      cx + rx, cy + ry * 0.55,
      cx + rx * 0.55, cy + ry - wobble,
      cx, cy + ry,
    );
    // Donja lijeva kriva
    path.cubicTo(
      cx - rx * 0.55, cy + ry + wobble,
      cx - rx, cy + ry * 0.55,
      cx - rx, cy,
    );
    // Gornja lijeva kriva
    path.cubicTo(
      cx - rx, cy - ry * 0.55,
      cx - rx * 0.55, cy - ry - wobble,
      cx, cy - ry,
    );

    path.close();
    canvas.drawPath(path, paint);

    // Highlight - sjaj na bubblu
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - rx * 0.2, cy - ry * 0.3),
        width: rx * 0.5,
        height: ry * 0.3,
      ),
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(LiquidBubblePainter old) =>
      old.progress != progress || old.color != color;
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : Appcolors.green1,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 13,
                color: isSelected ? Colors.white : Appcolors.green1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}