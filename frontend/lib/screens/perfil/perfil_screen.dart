import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Entrar no sistema",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            GlowButton(
              text: "Continuar com Google",
              color: Color(0xFFEA4335),
              icon: Icons.g_mobiledata,
            ),

            GlowButton(
              text: "Entrar com GOV.BR",
              color: Color(0xFF1351B4),
              icon: Icons.verified_user,
            ),

            GlowButton(
              text: "Entrar",
              color: Color(0xFF2E7D32),
              icon: Icons.login,
            ),
          ],
        ),
      ),
    );
  }
}

class GlowButton extends StatefulWidget {
  final String text;
  final Color color;
  final IconData icon;

  const GlowButton({
    super.key,
    required this.text,
    required this.color,
    required this.icon,
  });

  @override
  State<GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<GlowButton> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.symmetric(vertical: 12),

        transform: hover
            ? (Matrix4.identity()..scale(1.05))
            : Matrix4.identity(),

        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),

          color: widget.color,

          
          boxShadow: hover
              ? [
                 
                  BoxShadow(
                    color: widget.color.withOpacity(0.9),
                    blurRadius: 25,
                    spreadRadius: 3,
                  ),

                 
                  const BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 10),
                    blurRadius: 18,
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 8,
                  ),
                ],
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: Colors.white),
            const SizedBox(width: 12),
            Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}