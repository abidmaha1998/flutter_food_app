import 'package:food_app/shared/colors.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold est la structure de base du design matériel.
    return Scaffold(
      // Barre d'applications qui affiche le titre "About Us" avec une couleur personnalisée.

      appBar: AppBar(
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: appbarGreen,
      ),
      body: Center(
        // Padding pour ajouter de l'espace autour du contenu enfant.

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Colonne pour organiser les éléments verticalement.

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // Texte d'accueil avec une taille de police, un poids de police et une couleur personnalisés.

              Text(
                'Welcome to Our HelloFood!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(255, 151, 0, 1.0),
                ),
              ),
              SizedBox(height: 16),
 
              Text(
                'Our food ordering app has revolutionized how our customers discover, order, and savor exceptional cuisine. In partnership with talented chefs and renowned restaurants, we offer a diverse culinary experience to our users. The user-friendly nature of our platform allows food enthusiasts to explore a range of delights, customize their orders according to their preferences, and indulge in high-quality dishes delivered directly to their door. Our commitment to customer satisfaction is evident in every detail, from the meticulous selection of gastronomic partners to the guarantee of fast and reliable delivery. Immerse yourself in an unparalleled culinary adventure with our food ordering app, where quality, convenience, and culinary diversity converge to create an unforgettable experience for all food enthusiasts.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: About(),
  ));
}
