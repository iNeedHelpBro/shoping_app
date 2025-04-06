import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';

class PcsDetailsPage extends StatefulWidget {
  final Map<String, Object> pcs;
  final String? imgurl;
  final String? imgurl2;
  const PcsDetailsPage(
      {super.key, required this.pcs, this.imgurl, this.imgurl2});

  @override
  State<PcsDetailsPage> createState() => _PcsDetailsPageState();
}

class _PcsDetailsPageState extends State<PcsDetailsPage> {
  int selectedSize = 0;

  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct(
        {
          'id': widget.pcs['id'],
          'title': widget.pcs['title'],
          'price': widget.pcs['price'],
          'imageUrl': widget.pcs['imageUrl'],
          'company': widget.pcs['company'],
          'size': selectedSize,
        },
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added successfully!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a size!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(192, 230, 250, 255),
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Column(
        children: [
          Text(
            widget.pcs['title'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 40, 0),
                    child: Image.asset(
                      widget.pcs['imageUrl'] as String,
                      height: 300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 40, 0),
                    child: widget.imgurl == null || widget.imgurl!.isEmpty
                        ? Text('')
                        : Image.asset(widget.imgurl!, height: 300),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 0, 40, 0),
                    child: widget.imgurl2 == null || widget.imgurl2!.isEmpty
                        ? Text('')
                        : Image.asset(widget.imgurl2!, height: 300),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 2),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PHP${widget.pcs['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.pcs['sizes'] as List<int>).length,
                    itemBuilder: (context, index) {
                      final size = (widget.pcs['sizes'] as List<int>)[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Chip(
                            label: Text('RAM: ${size.toString()}GB'),
                            backgroundColor: selectedSize == size
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      fixedSize: const Size(350, 50),
                    ),
                    child: const Text(
                      'Add To Cart',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
