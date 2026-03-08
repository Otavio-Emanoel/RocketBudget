import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

class AnimatedAstroRocket extends StatelessWidget {
  final double size;
  
  const AnimatedAstroRocket({super.key, this.size = 200});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Thruster flames (Animated)
          Positioned(
            bottom: size * 0.0,
            child: Container(
              width: size * 0.25,
              height: size * 0.35,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(100, 150)),
                gradient: RadialGradient(
                  center: const Alignment(0.0, -0.6),
                  radius: 0.8,
                  colors: [
                    Colors.white,
                    Colors.orange.shade300,
                    Colors.red.withOpacity(0.8),
                    Colors.transparent
                  ],
                  stops: const [0.0, 0.4, 0.7, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.6),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ],
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true))
            .scaleXY(begin: 0.8, end: 1.1, duration: 250.ms, curve: Curves.easeInOut)
            .fadeIn(duration: 250.ms),
          ),
          
          // Flame inner core
          Positioned(
            bottom: size * 0.08,
            child: Container(
              width: size * 0.1,
              height: size * 0.2,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.elliptical(50, 100)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.white, blurRadius: 10, spreadRadius: 2)
                ]
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true))
            .scaleXY(begin: 0.9, end: 1.1, duration: 150.ms),
          ),

          // Rocket Structure - Body and Fins
          Positioned.fill(
             child: CustomPaint(
               painter: _RocketPainter(),
             ),
          ),
          
          // Window Base
          Positioned(
            top: size * 0.32,
            child: Container(
              width: size * 0.3,
              height: size * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0f2023), // Dark space reflect
                border: Border.all(color: Colors.grey.shade400, width: size * 0.03),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 8),
                  BoxShadow(color: Colors.black26, offset: const Offset(0, 4), blurRadius: 4),
                ],
              ),
            ),
          ),

          // Window Glass Reflection (Gradients)
          Positioned(
            top: size * 0.32 + size * 0.03, // inside border
            child: Container(
              width: size * 0.24,
              height: size * 0.24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1.0,
                  colors: [
                    Colors.white.withOpacity(0.6),
                    Colors.lightBlueAccent.withOpacity(0.2),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
          
          // Small twinkling star on the window
          Positioned(
            top: size * 0.36,
            left: size * 0.42,
            child: Icon(Icons.star, color: Colors.white, size: size * 0.08)
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(begin: 0.5, end: 1.2, duration: 600.ms)
                .fadeOut(duration: 600.ms),
          ),

        ],
      ).animate(onPlay: (c) => c.repeat(reverse: true))
       .moveY(begin: -size * 0.02, end: size * 0.02, duration: 2.seconds, curve: Curves.easeInOutSine),
    );
  }
}

class _RocketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final cx = w / 2;
    
    // Engine / Thruster base (Bottom)
    final enginePath = Path();
    enginePath.moveTo(cx - w * 0.12, h * 0.75);
    enginePath.lineTo(cx + w * 0.12, h * 0.75);
    enginePath.lineTo(cx + w * 0.15, h * 0.85);
    enginePath.quadraticBezierTo(cx, h * 0.88, cx - w * 0.15, h * 0.85);
    enginePath.close();
    
    final enginePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.grey.shade800, Colors.grey.shade400, Colors.grey.shade900],
        stops: const [0.0, 0.4, 1.0]
      ).createShader(Rect.fromLTWH(cx - w * 0.15, h * 0.75, w * 0.3, h * 0.13));
    canvas.drawPath(enginePath, enginePaint);

    // Left Fin
    final leftFinPath = Path();
    leftFinPath.moveTo(cx - w * 0.18, h * 0.55);
    leftFinPath.quadraticBezierTo(cx - w * 0.4, h * 0.65, cx - w * 0.45, h * 0.85);
    leftFinPath.lineTo(cx - w * 0.22, h * 0.8);
    leftFinPath.close();

    // Fin Gradient (Neon Blue fading to dark)
    final leftFinPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.neonBlue, const Color(0xFF005577)],
      ).createShader(Rect.fromLTWH(cx - w * 0.45, h * 0.55, w * 0.27, h * 0.3));
    
    canvas.drawPath(leftFinPath, Paint()..color = Colors.black38..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)); // shadow
    canvas.drawPath(leftFinPath, leftFinPaint);

    // Right Fin
    final rightFinPath = Path();
    rightFinPath.moveTo(cx + w * 0.18, h * 0.55);
    rightFinPath.quadraticBezierTo(cx + w * 0.4, h * 0.65, cx + w * 0.45, h * 0.85);
    rightFinPath.lineTo(cx + w * 0.22, h * 0.8);
    rightFinPath.close();

    final rightFinPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [AppColors.neonBlue.withOpacity(0.8), const Color(0xFF003355)],
      ).createShader(Rect.fromLTWH(cx + w * 0.18, h * 0.55, w * 0.27, h * 0.3));
    
    canvas.drawPath(rightFinPath, Paint()..color = Colors.black38..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8)); // shadow
    canvas.drawPath(rightFinPath, rightFinPaint);
    
    // Center Fin
    final centerFinPath = Path();
    centerFinPath.moveTo(cx, h * 0.6);
    centerFinPath.lineTo(cx - w * 0.03, h * 0.82);
    centerFinPath.lineTo(cx + w * 0.03, h * 0.82);
    centerFinPath.close();
    canvas.drawPath(centerFinPath, Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [AppColors.neonBlue, const Color(0xFF0088AA), const Color(0xFF005577)],
      ).createShader(Rect.fromLTWH(cx - w * 0.03, h * 0.6, w * 0.06, h * 0.22))
    );

    // Main Body (White/Grey Metallic Cylinder)
    final bodyPath = Path();
    bodyPath.moveTo(cx, h * 0.05); // Tip
    bodyPath.quadraticBezierTo(cx + w * 0.28, h * 0.25, cx + w * 0.22, h * 0.75); // Right curve
    bodyPath.quadraticBezierTo(cx, h * 0.8, cx - w * 0.22, h * 0.75); // Bottom curve
    bodyPath.quadraticBezierTo(cx - w * 0.28, h * 0.25, cx, h * 0.05); // Left curve
    bodyPath.close();

    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.grey.shade400,
          Colors.white,
          Colors.grey.shade200,
          Colors.grey.shade400,
          Colors.grey.shade600,
        ],
        stops: const [0.0, 0.2, 0.4, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(cx - w * 0.28, 0, w * 0.56, h));
    
    // Drop shadow for the body
    canvas.drawPath(bodyPath, Paint()..color = Colors.black45..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12));
    canvas.drawPath(bodyPath, bodyPaint);
    
    // Nose Cone (Red/Blue Tip)
    final nosePath = Path();
    nosePath.moveTo(cx, h * 0.05); // Tip
    nosePath.quadraticBezierTo(cx + w * 0.12, h * 0.15, cx + w * 0.16, h * 0.22); 
    nosePath.lineTo(cx - w * 0.16, h * 0.22);
    nosePath.quadraticBezierTo(cx - w * 0.12, h * 0.15, cx, h * 0.05);
    nosePath.close();
    
    final nosePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
            AppColors.neonBlue.withOpacity(0.5), 
            AppColors.neonBlue, 
            const Color(0xFF006688)
        ],
        stops: const [0.0, 0.3, 1.0]
      ).createShader(Rect.fromLTWH(cx - w * 0.16, 0, w * 0.32, h));
    canvas.drawPath(nosePath, nosePaint);

    // Separator line between nose and body
    canvas.drawLine(
       Offset(cx - w * 0.16, h * 0.22), 
       Offset(cx + w * 0.16, h * 0.22), 
       Paint()..color = Colors.grey.shade600..strokeWidth = 3
    );
     
    // Lower body line (near engine)
    canvas.drawArc(
        Rect.fromCenter(center: Offset(cx, h * 0.72), width: w * 0.4, height: h * 0.08), 
        0, 3.14, false, 
        Paint()..color = Colors.grey.shade500..strokeWidth = 2..style = PaintingStyle.stroke
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
