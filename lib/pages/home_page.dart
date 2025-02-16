import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart/login_check.dart';
import 'package:flutter_application_1/models/Product.dart';
import 'package:flutter_application_1/widgets/list_of_card.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> displayedProducts = [];
  String searchInput = '';
  String selectedCategory = 'All';
  bool sortAscending = true;

  @override
  void initState() {
    super.initState();
    displayedProducts = products;
  }

  bool checkLoggedIn() {
    return isLoggedIn;
  }

  void searchProducts(String query) {
    setState(() {
      searchInput = query;
      displayedProducts = products.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void sortProducts() {
    setState(() {
      sortAscending = !sortAscending;
      displayedProducts.sort((a, b) => sortAscending
          ? a.price.compareTo(b.price)
          : b.price.compareTo(a.price));
    });
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
      } else {
        displayedProducts = products.where((product) {
          return product.category == category;
        }).toList();
      }
    });
  }

  List<Widget> buildProductPairs() {
    List<Widget> productPairs = [];
    for (int i = 0; i < displayedProducts.length; i += 2) {
      var firstProduct = displayedProducts[i];
      var secondProduct =
          (i + 1 < displayedProducts.length) ? displayedProducts[i + 1] : null;

      productPairs.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ProductCard(firstProduct),
              ),
              if (secondProduct != null)
                Expanded(
                  child: ProductCard(secondProduct),
                ),
            ],
          ),
        ),
      );
    }
    return productPairs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        toolbarHeight: 100,
        leading: Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Container(
            width: 60,
            height: 60,
            child: Image.asset(
              "assets/logo.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: const Center(
            child: Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    "OptimUz",
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: "san-serif",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        )),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.dashboard, size: 40),
            onSelected: filterByCategory,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'All',
                child: Text('All'),
              ),
              const PopupMenuItem<String>(
                value: 'Health & care',
                child: Row(
                  children: [
                    Icon(Icons.health_and_safety),
                    SizedBox(width: 10),
                    Text('Health & care'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Electronics',
                child: Row(
                  children: [
                    Icon(Icons.devices),
                    SizedBox(width: 10),
                    Text('Electronics'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Sport',
                child: Row(
                  children: [
                    Icon(Icons.run_circle_outlined),
                    SizedBox(width: 10),
                    Text('Sport'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Clothes',
                child: Row(
                  children: [
                    Icon(Icons.checkroom_sharp),
                    SizedBox(width: 10),
                    Text('Clothes'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Equipment',
                child: Row(
                  children: [
                    Icon(Icons.home_repair_service),
                    SizedBox(width: 10),
                    Text('Equipment'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search",
                    prefixIconColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: searchProducts,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedCategory == 'All'
                            ? 'All Products'
                            : " ${selectedCategory}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'sans-serif',
                          letterSpacing: 1,
                        ),
                      ),
                      IconButton(
                          onPressed: sortProducts,
                          icon: Icon(
                            Icons.sort_outlined,
                            size: 35,
                            color: Colors.black,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Builder(builder: (context) {
              return ListView(
                children: buildProductPairs(),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        onPressed: () {
          if (isLoggedIn) {
            context.push("/add");
          } else {
            context.push("/login");
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.grey,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(7, 0, 3, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${product.category}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            Center(
                child: product.imageUrl.isEmpty
                    ? Placeholder(
                        fallbackHeight: 140,
                        fallbackWidth: 140,
                        strokeWidth: 5,
                      )
                    : Image.network(
                        product.imageUrl,
                        height: 140,
                        fit: BoxFit.cover,
                      )),
            SizedBox(height: 13),
            Text(
              product.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${product.price}\$',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'san-serif',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
