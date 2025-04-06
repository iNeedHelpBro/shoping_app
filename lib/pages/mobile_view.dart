// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:neumorphic_ui/neumorphic_ui.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Products.dart/laptop_details_page.dart';
import 'package:shopping_app/Products.dart/pcs.dart';
import 'package:shopping_app/Products.dart/pcs_details_page.dart';
import 'package:shopping_app/Products.dart/phones.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/pages/cart_page.dart';
import 'package:shopping_app/pages/currency_converter.dart';
import 'package:shopping_app/Products.dart/laptops.dart';
import 'package:shopping_app/themes/themeProvider.dart';

import '../Products.dart/phone_details_page.dart';

class MobileView extends StatefulWidget {
  const MobileView({
    super.key,
  });

  @override
  State<MobileView> createState() => _MobileViewState();
}

class _MobileViewState extends State<MobileView> {
  final List<String> filters = const ['All', 'Laptops', 'Phones', 'PCs'];
  double? widthSize;
  late String selectedFilter;
  late List<Map<String, Object>> shuffledLaptops, shuffledProducts, shuffledPcs;
  // Color changeToDark = ThemeProvider.isDarkmode ? Color.fromARGB(255, 85, 84, 84) : Color.fromARGB(255, 239, 236, 190);
  // Color changeToLight = ThemeProvider.isDarkmode ? Color.fromARGB(255, 70, 70, 64) : Color.fromARGB(255, 255, 255, 231);

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    shuffledProducts = List.from(products);
    shuffledLaptops = List.from(laptops);
    shuffledPcs = List.from(pcs);
    shuffleTheProducts();
  }

  void shuffleTheProducts() {
    shuffledPcs.shuffle(Random());
    shuffledProducts.shuffle(Random());
    shuffledLaptops.shuffle(Random());
  }

  @override
  Widget build(BuildContext context) {
    widthSize = MediaQuery.of(context).size.width;
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(126, 108, 108, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 40.0, left: 70.0),
            child: Text(
              'J A Y\'s\nT E\'C H',
              style: TextStyle(
                decoration: TextDecoration.combine([
                  TextDecoration.underline,
                  TextDecoration.overline,
                ]),
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Wallman-Bold',
              ),
            ),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  color: ThemeProvider.isDarkmode
                      ? Colors.teal[700]
                      : Colors.lime[100]),
              child: Center(
                child: Text(
                  'J A Y\'s\nT E\'C H',
                  style: TextStyle(
                    decoration: TextDecoration.combine([
                      TextDecoration.underline,
                      TextDecoration.overline,
                    ]),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Wallman-Bold',
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Cart'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
            ),
            ListTile(
              title: Text('Currency Converter'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CurrencyConverter()));
              },
            ),
            ListTile(
              title: Icon(
                Icons.lightbulb,
                size: 35,
              ),
              onTap: () {
                setState(() {
                  selectedFilter = filters[0];
                  Provider.of<ThemeProvider>(context, listen: false)
                      .switchMode();
                });
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              addRepaintBoundaries: true,
              itemCount: filters.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                        shuffleTheProducts();
                      });
                    },
                    child: Chip(
                      backgroundColor: selectedFilter == filter
                          ? ThemeProvider.isDarkmode
                              ? Color.fromARGB(255, 36, 34, 34)
                              : Color.fromARGB(255, 232, 201, 66)
                          : ThemeProvider.isDarkmode
                              ? Color.fromARGB(255, 64, 82, 97)
                              : Color.fromARGB(255, 215, 237, 255),
                      side: const BorderSide(
                        color: Color.fromRGBO(245, 247, 249, 1),
                      ),
                      label: Text(filter),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemExtent: 300,
              itemCount: getFilteredProducts().length,
              itemBuilder: (context, index) {
                final product = getFilteredProducts()[index];
                print('Mobile View\nScreen Width: $widthSize');

                if (selectedFilter == 'Laptops') {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return LaptopDetailsPage(
                              laptop: product,
                              imgurl: product['imageUrl2'] as String,
                              imgurl2: product['imageUrl3'] as String,
                            );
                          },
                        ),
                      );
                    },
                    child: Laptops(
                      title: product['title'] as String,
                      image: product['imageUrl'] as String,
                      price: product['price'] as double,
                      backgroundColor: index.isEven
                          ? ThemeProvider.isDarkmode
                              ? Color.fromARGB(255, 85, 84, 84)
                              : Color.fromARGB(255, 239, 236, 190)
                          : ThemeProvider.isDarkmode
                              ? Color.fromARGB(255, 70, 70, 64)
                              : Color.fromARGB(255, 255, 255, 231),
                    ),
                  );
                } else if (selectedFilter == 'Phones') {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return PhoneDetailsPage(
                              product: product,
                            );
                          },
                        ),
                      );
                    },
                    child: Phones(
                      title: product['title'] as String,
                      price: product['price'] as double,
                      image: product['imageUrl'] as String,
                      backgroundColor: index.isEven
                          ? ThemeProvider.isDarkmode
                              ? Color.fromARGB(255, 85, 84, 84)
                              : Color.fromARGB(255, 239, 236, 190)
                          : ThemeProvider.isDarkmode
                              ? Color.fromARGB(255, 70, 70, 64)
                              : Color.fromARGB(255, 255, 255, 231),
                    ),
                  );
                } else if (selectedFilter == 'PCs') {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return PcsDetailsPage(
                              pcs: product,
                              imgurl: product.containsKey('imageUrl2')
                                  ? product['imageUrl2'] as String?
                                  : null,
                              imgurl2: product.containsKey('imageUrl3')
                                  ? product['imageUrl3'] as String?
                                  : null,
                            );
                          },
                        ),
                      );
                    },
                    child: Pcs(
                      title: product['title'] as String,
                      image: product['imageUrl'] as String,
                      price: product['price'] as double,
                      backgroundColor: index.isEven
                          ? ThemeProvider.isDarkmode
                              ? Color.fromARGB(255, 85, 84, 84)
                              : Color.fromARGB(255, 239, 236, 190)
                          : ThemeProvider.isDarkmode
                              ? Color.fromARGB(255, 70, 70, 64)
                              : Color.fromARGB(255, 255, 255, 231),
                    ),
                  );
                }

                // Handle the 'All' filter to display all products
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return PhoneDetailsPage(
                            product: product,
                          );
                        },
                      ),
                    );
                  },
                  child: Phones(
                    title: product['title'] as String,
                    price: product['price'] as double,
                    image: product['imageUrl'] as String,
                    backgroundColor: index.isEven
                        ? ThemeProvider.isDarkmode
                            ? Color.fromARGB(255, 85, 84, 84)
                            : Color.fromARGB(255, 239, 236, 190)
                        : ThemeProvider.isDarkmode
                            ? Color.fromARGB(255, 70, 70, 64)
                            : Color.fromARGB(255, 255, 255, 231),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, Object>> getFilteredProducts() {
    if (selectedFilter == 'All') {
      return [...shuffledProducts, ...shuffledLaptops, ...shuffledPcs];
    } else if (selectedFilter == 'Laptops') {
      return shuffledLaptops;
    } else if (selectedFilter == 'Phones') {
      return shuffledProducts;
    } else if (selectedFilter == 'PCs') {
      return shuffledPcs;
    }
    return shuffledProducts;
  }
}
