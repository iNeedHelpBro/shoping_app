import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyApi {
  final String baseUrl =
      'https://api.currencyapi.com/v3/latest?apikey=cur_live_Ndh9a8bMNiZWSPRLb6e5jFTp6C5et1AVRe7mpjFP';
  static CurrencyApi instance = CurrencyApi();

  Future<Map<String, dynamic>> getCurrency(List<String> currencies) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rates = data['data'] as Map<String, dynamic>;

        final filteredRates = {
          for (var currency in currencies)
            if (rates.containsKey(currency)) currency: rates[currency]
        };

        return filteredRates;
      } else {
        throw Exception('Failed to load currency data');
      }
    } catch (e) {
      throw Exception('Failed to load currency data: $e');
    }
  }
}
