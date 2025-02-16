import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/Product.dart';
import 'package:flutter_application_1/widgets/list_of_card.dart';
import 'package:go_router/go_router.dart';
class AddNewProductPage extends StatefulWidget {
  const AddNewProductPage({super.key});
  @override
  State<AddNewProductPage> createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  String? selectedCategory;
  bool isSubmitEnabled = true;

  List<String> categories = [
   
    "Electronics",
    "Sport",
    "Health & Care",
    "Clothes",
    "Equipment",
    
  ];
  
  void checkSubmitStatus() {
    setState(() {
      isSubmitEnabled = titleController.text.isNotEmpty &&
          priceController.text.isNotEmpty &&
          imageUrlController.text.isNotEmpty &&
          selectedCategory != null;
    });
  }

  
  void addProduct() {
    final newProduct = Product(
      title: titleController.text,
      category: selectedCategory!,
      price: double.parse(priceController.text),
      imageUrl: imageUrlController.text,
    );

   
    products.insert(0, newProduct);

    context.go("/home");

  }

  @override
  void initState() {
    super.initState();
    titleController.addListener(checkSubmitStatus);
    priceController.addListener(checkSubmitStatus);
    imageUrlController.addListener(checkSubmitStatus);
  }

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }


@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              context.go("/home");
            },
            icon: Icon(
              Icons.home,
              color: Color(0xfffFF7828),
            )),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                child: Text(
                  "Add new product",
                  style: TextStyle(
                      color: Color(0xfff715CF8),
                      fontWeight: FontWeight.w900,
                      fontSize: 35,
                      fontFamily: 'san-serif'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: "Enter a product name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Price of product",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: imageUrlController,
                      decoration: InputDecoration(
                          hintText: "Image URL",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30))),
                    ),
                    SizedBox(height: 20),
                    PopupMenuButton<String>(
                      onSelected: (String value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      itemBuilder: (BuildContext context) =>
                          categories.map((String value) {
                        return PopupMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      child: ListTile(
                        title: Text(selectedCategory ?? 'Select Category'),
                        trailing: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                    SizedBox(height: 20),
                    MaterialButton(
                        shape: StadiumBorder(),
                        minWidth: 200,
                        height: 50,
                        onPressed: () {
                          addProduct();
                        },
                        child: Text(
                          "ADD",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'san-serif',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3),
                        ),
                        color: Color(0xfff715CF8)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
