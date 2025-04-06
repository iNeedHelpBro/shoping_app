// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';
import 'package:shopping_app/service/navigator.dart';
import 'package:shopping_app/widgets/successDialog.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    late Map<String, dynamic> cartItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                'Your Cart is Empty',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Wallman-Bold',
                ),
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: ListView.builder(
                    //itemExtent: 300,
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      cartItem = cart[index];
                      /*
                            
                    CONTINUE FROM HERE, ADD 'PLACE ORDER' BUTTON BELOW THE LISTVIEW
                            
                    */
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage(cartItem['imageUrl'] as String),
                          radius: 30,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Delete Product',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  content: const Text(
                                    'Are you sure you want to remove the product from your cart?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        'No',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<CartProvider>()
                                            .removeProduct(cartItem);
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                                child: SuccessDialog(
                                                    message:
                                                        'Product Deleted!'));
                                          },
                                        );
                                      },
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        title: Text(
                          cartItem['title'].toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        subtitle: Text('Price: ${cartItem['price']}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 190),
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.blue),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      )),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (cart.isNotEmpty) {
                        context.read<CartProvider>().clearCart();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                                child: SuccessDialog(
                                    message:
                                        'SUCCESSFULLY ORDERED!\nYour order is on its way!'));
                          },
                        ).then((_) {
                          NavigatorService.navigate.stayInCurrentPage();
                        });
                      }
                    },
                    child: Text(
                      'PLACE ORDER\nTotal: PHP${cart.fold<double>(0, (sum, item) => sum + item['price'])}',
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
