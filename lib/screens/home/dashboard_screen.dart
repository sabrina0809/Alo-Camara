import 'package:flutter/material.dart';

import 'home_screen.dart';
import '../vereadores/vereadores_screen.dart';
import '../notificacoes/notificacoes_screen.dart';
import '../agenda/agenda_screen.dart';
import '../config/config_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final List<Widget> screens = [
      const HomeScreen(),
      const VereadoresScreen(),
      const NotificacoesScreen(),
      const AgendaScreen(),
      const ConfigScreen(),
    ];

    return Scaffold(
      body: screens[_currentIndex],

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0F172A),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10,
              offset: Offset(0, -2),
            )
          ],
        ),

        child: BottomNavigationBar(
          backgroundColor: const Color(0xFF0F172A),

          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,

          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.white54,

          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),

          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
          ),

          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Vereadores',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: 'Notificações', 
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Agenda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Config',
            ),
          ],
        ),
      ),
    );
  }
}