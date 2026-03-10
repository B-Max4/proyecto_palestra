import 'package:app_palestra/routes/routes.dart';
import 'package:flutter/material.dart';

class ScreenBienvenida extends StatelessWidget {
  const ScreenBienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 15, 181, 223),
              Color.fromARGB(255, 6, 74, 219),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo o imagen de bienvenida
            Image.asset(
              'assets/logo.png', // Pon tu logo en assets y declara en pubspec.yaml
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 30),
            const Text(
              '¡Bienvenido a Mi App!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí vas a la siguiente pantalla
                Navigator.pushReplacementNamed(context, Approutes.atletas);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Comenzar', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
