class Item {
  String imgPath;
  double price;
  String location;
  String name;

  Item({required this.imgPath, required this.name, required this.price, this.location = "Hellofood"});
}

final List<Item> items = [
  Item(name: "Burger", price: 1, imgPath: "assets/burgers/b2.jpg", location: "Hellofood"),
  Item(name: "Pizza", price: 3, imgPath: "assets/pizza/p1.jpg", location: "Hellofood"),
  Item(name: "Pasta", price: 5, imgPath: "assets/pizza/pas1.jpg", location: "Hellofood"),
  Item(name: "Pizza", price: 10, imgPath: "assets/pizza/p2.png", location: "Hellofood"),
  Item(name: "Plat", price: 15, imgPath: "assets/popular_foods/po3.png", location: "Hellofood"),
  Item(name: "Pizza", price: 20, imgPath: "assets/pizza/p3.png", location: "Hellofood"),
  Item(name: "Plat", price: 25, imgPath: "assets/popular_foods/po1.png", location: "Hellofood"),
  Item(name: "Plat", price: 30, imgPath: "assets/popular_foods/po2.png", location: "Hellofood"),
];
