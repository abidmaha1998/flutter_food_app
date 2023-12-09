import 'package:food_app/model/item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List selectedProducts = []; // Liste des produits sélectionnés dans le panier
  int price = 0; // Prix total du panier

  // Fonction pour ajouter un produit au panier
  add(Item product) {
    selectedProducts.add(product); // Ajoute le produit à la liste
    price += product.price
        .round(); // Ajoute le prix du produit au prix total du panier (arrondi à la valeur entière)
    notifyListeners(); // Notifie les auditeurs (widgets écoutant les changements) du changement d'état
  }

  // Fonction pour supprimer un produit du panier
  delete(Item product) {
    selectedProducts.remove(product); // Supprime le produit de la liste
    price -= product.price
        .round(); // Soustrait le prix du produit du prix total du panier (arrondi à la valeur entière)
    notifyListeners(); // Notifie les auditeurs du changement d'état
  }

  // Getter pour obtenir le nombre total d'articles dans le panier
  get itemCount {
    return selectedProducts.length;
  }
}
