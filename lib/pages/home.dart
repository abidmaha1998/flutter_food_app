// La ligne ci-dessus ignore les avertissements de linter concernant la préférence des constructeurs constants.
// Importation de packages nécessaires.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/model/item.dart';
import 'package:food_app/pages/About.dart';
import 'package:food_app/pages/checkout.dart';
import 'package:food_app/pages/details_screen.dart';
import 'package:food_app/pages/profile_page.dart';
import 'package:food_app/pages/sign_in.dart';
import 'package:food_app/provider/cart.dart';
import 'package:food_app/shared/appbar.dart';
import 'package:food_app/shared/colors.dart';
import 'package:food_app/shared/user_img_from_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Classe Home qui représente l'écran d'accueil de l'application.
class Home extends StatelessWidget {
  // Constructeur de la classe Home.
  Home({super.key});

  // Instances de FirebaseAuth et FirebaseFirestore pour l'authentification et l'accès à la base de données Firestore.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('userSSS');

  @override
  Widget build(BuildContext context) {
    // Accès au fournisseur (provider) Cart en utilisant Provider.of.
    final carttt = Provider.of<Cart>(context);

    // Retourne le widget Scaffold qui est la structure visuelle de base du design matériel.
    return Scaffold(
      // Corps de la page avec un Padding pour ajouter de l'espace autour de l'enfant.
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        // GridView.builder crée une grille 2D de widgets pouvant défiler.
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            // GestureDetector pour gérer les clics sur les éléments de la grille.
            return GestureDetector(
              onTap: () {
                // Navigation vers l'écran de détails avec une animation de transition par défaut
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return Details(product: items[index]);
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // Départ à droite
                      const end = Offset.zero; // Fin à zéro (centre de l'écran)

                      var tween = Tween(begin: begin, end: end);
                      var offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                    // Optionnel : spécifiez la durée de l'animation
                    transitionDuration: const Duration(milliseconds: 500),
                  ),
                );
              },
              child: GridTile(
                // GridTile pour chaque élément de la grille.
                footer: GridTileBar(
                      backgroundColor: bagtxt,
                      trailing: IconButton(
                        color: txtcol,
                        onPressed: () {
                          carttt.add(items[index]);
                        },
                        icon: const Icon(Icons.add),
                      ),
                      leading: Text('${items[index].price} Dt',
                          style: TextStyle(color: txtcol)),
                      title: Text(items[index].name,
                          style: TextStyle(color: txtcol, fontSize: 15)),
                    ),
                child: Stack(
                  children: [
                    Positioned(
                      // Positioned pour positionner l'image dans la Stack.
                      top: -3,
                      bottom: -9,
                      right: 0,
                      left: 0,
                      child: ClipRRect(
                        // ClipRRect pour découper l'image avec des coins arrondis.
                        borderRadius: BorderRadius.circular(55),
                        child: Image.asset(items[index].imgPath),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      // Drawer pour créer un tiroir de navigation.
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // FutureBuilder pour construire de manière asynchrone l'interface utilisateur en fonction de l'état d'authentification.
                FutureBuilder<User?>(
                  future: FirebaseAuth.instance.authStateChanges().first,
                  builder:
                      (BuildContext context, AsyncSnapshot<User?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text(
                          "Erreur lors du chargement des données utilisateur");
                    } else if (!snapshot.hasData || snapshot.data == null) {
                      return Text("Aucun utilisateur connecté");
                    }

                    // Afficher les informations de l'utilisateur dans l'en-tête du tiroir.
                    User? user = snapshot.data;
                    String userEmail = user!.email ?? "";
                    String username = "";
                    return UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/img/test.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      currentAccountPicture: ImgUser(),
                      accountEmail: Text(userEmail),
                      accountName: FutureBuilder<DocumentSnapshot>(
                        future: _usersCollection.doc(user.uid).get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text(
                                "Erreur lors du chargement du nom d'utilisateur");
                          } else if (!snapshot.hasData ||
                              !snapshot.data!.exists) {
                            return Text("Aucun nom d'utilisateur disponible");
                          }

                          // Récupérer et afficher le nom d'utilisateur depuis Firestore.
                          username = snapshot.data!['username'] ??
                              "Nom d'utilisateur non disponible";
                          return Text(
                            username,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                // ListTiles pour diverses options de navigation dans le tiroir.
                ListTile(
                    title: const Text("Home"),
                    leading: const Icon(Icons.home),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("My products"),
                    leading: const Icon(Icons.add_shopping_cart),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CheckOut(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("About"),
                    leading: const Icon(Icons.help_center),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => About(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Profile Page"),
                    leading: const Icon(Icons.person),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text("Logout"),
                    leading: const Icon(Icons.exit_to_app),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: const Text("Developed by Omar & Maha",
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: const [ProductsAndPrice()],
          backgroundColor: appbarGreen,
          title: const Text("Home", style: TextStyle(color: Colors.white)),
        ));
  }
}
