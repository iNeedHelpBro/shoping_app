import 'package:flutter/material.dart';
import 'package:shopping_app/service/currency_api.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() {
    return _CurrencyConverterState();
  }
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  double php = 0.0;
  double yen = 0.0;
  double euro = 0.0;

  final TextEditingController textEditingController = TextEditingController();
  Map<String, dynamic>? exchangeRates;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    try {
      final rates =
          await CurrencyApi.instance.getCurrency(['USD', 'EUR', 'JPY', 'PHP']);
      setState(() {
        exchangeRates = rates;
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch exchange rates')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: const Color.fromRGBO(101, 230, 3, 0.253),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Euro Currency.',
                      style: TextStyle(
                          fontSize: 17.3,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(23, 100, 201, 0.768)),
                    ),
                    Text(
                      euro.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 40.3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Yen Currency.',
                      style: TextStyle(
                          fontSize: 17.3,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(23, 100, 201, 0.768)),
                    ),
                    Text(
                      yen.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 40.3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'PHP Currency',
                      style: TextStyle(
                          fontSize: 17.3,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(23, 100, 201, 0.768)),
                    ),
                    Text(
                      php.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 40.3,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(45.0),
                      child: TextField(
                        controller: textEditingController,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 39, 38, 39),
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Input your peso amount',
                          hintStyle: TextStyle(
                            color: Colors.blueAccent,
                          ),
                          prefixIcon: Icon(Icons.monetization_on_outlined),
                          prefixIconColor: Color.fromARGB(255, 208, 174, 18),
                          filled: true,
                          fillColor: Color.fromARGB(255, 221, 214, 193),
                          enabledBorder: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(23)),
                              borderSide: BorderSide(width: 3)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(46, 61, 52, 1),
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(23)),
                          ),
                        ),
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (textEditingController.text.isNotEmpty &&
                            exchangeRates != null) {
                          setState(() {
                            final pesoAmount =
                                double.parse(textEditingController.text);
                            php = pesoAmount * exchangeRates!['PHP']['value'];
                            yen = pesoAmount * exchangeRates!['JPY']['value'];
                            euro = pesoAmount * exchangeRates!['EUR']['value'];
                          });
                          textEditingController.clear();
                          // print('USD: ${exchangeRates!['USD']['value']}');
                          // print('JPY: ${exchangeRates!['JPY']['value']}');
                          // print('EUR: ${exchangeRates!['EUR']['value']}');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a value!'),
                            ),
                          );
                        }
                      },
                      style: const ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(90, 23)),
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.lightGreen),
                        foregroundColor: WidgetStatePropertyAll(Colors.black),
                        textStyle: WidgetStatePropertyAll(TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500)),
                      ),
                      child: const Text('Convert'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
