// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopping_app/Products.dart/laptop_details_page.dart';
import 'package:shopping_app/Products.dart/laptops.dart';
import 'package:shopping_app/Products.dart/pcs.dart';
import 'package:shopping_app/Products.dart/pcs_details_page.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/pages/mobile_view.dart';
import 'package:shopping_app/Products.dart/phones.dart';
import 'package:shopping_app/Products.dart/phone_details_page.dart';
import 'dart:math';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Laptops', 'Phones', 'PCs'];
  late String selectedFilter;
  late List<Map<String, Object>> shuffledProducts;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
    shuffledProducts = List.from(products);
    shuffleProducts();
  }

  void shuffleProducts() {
    setState(() {
      shuffledProducts.shuffle(Random());
    });
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(126, 108, 108, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
      ),
    );

    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 614) {
          return RefreshIndicator(
            onRefresh: () async {
              shuffleProducts();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'M A R K\nT E C H',
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
                    const Expanded(
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
                SizedBox(
                  height: 120,
                  child: ListView.builder(
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
                            });
                          },
                          child: Chip(
                            backgroundColor: selectedFilter == filter
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.surfaceDim,
                            side: const BorderSide(
                              color: Color.fromRGBO(245, 247, 249, 1),
                            ),
                            label: Text(filter),
                            elevation: 10,
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: GridView.builder(
                      itemCount: shuffledProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 1.50),
                      itemBuilder: (context, index) {
                        //final product = shuffledProducts[index];
                        final Map<String, Object> phones =
                            shuffledProducts[index];
                        final laptop = laptops[index];
                        final pc = pcs[index];
                        print('Web View');
                        if (selectedFilter.contains('Laptops')) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return LaptopDetailsPage(
                                      laptop: laptop,
                                      imgurl: laptop['imageUrl2'] as String,
                                      imgurl2: laptop['imageUrl3'] as String,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Laptops(
                                title: laptop['title'] as String,
                                image: laptop['imageUrl'] as String,
                                price: laptop['price'] as double,
                                backgroundColor: index.isEven
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.tertiary),
                          );
                        } else if (selectedFilter.contains('Phones')) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PhoneDetailsPage(
                                      product: phones,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Phones(
                              title: phones['title'] as String,
                              price: phones['price'] as double,
                              image: phones['imageUrl'] as String,
                              backgroundColor: index.isEven
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.tertiary,
                            ),
                          );
                        } else if (selectedFilter.contains('PCs')) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PcsDetailsPage(
                                      pcs: pc,
                                      imgurl: pc.containsKey('imageUrl2')
                                          ? pc['imageUrl2'] as String?
                                          : null,
                                      imgurl2: pc.containsKey('imageUrl3')
                                          ? pc['imageUrl3'] as String?
                                          : null,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Pcs(
                                title: pc['title'] as String,
                                image: pc['imageUrl'] as String,
                                price: pc['price'] as double,
                                backgroundColor: index.isEven
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.tertiary),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return PhoneDetailsPage(
                                    product: phones,
                                  );
                                },
                              ),
                            );
                          },
                          child: Phones(
                            title: phones['title'] as String,
                            price: phones['price'] as double,
                            image: phones['imageUrl'] as String,
                            backgroundColor: index.isEven
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.tertiary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return MobileView();
        }
      }),
    );
  }
}
