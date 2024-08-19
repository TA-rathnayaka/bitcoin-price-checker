import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

final String apiKey = dotenv.env['API_KEY'] ?? "";
final String apiEndPoint = dotenv.env['API_ENDPOINT'] ?? "";

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  Future<double> getCoinData(String requiredCoin, String requiredUnit) async {
    var url = Uri.https('rest.coinapi.io', '/v1/exchangerate/$requiredCoin/$requiredUnit', {
      'apikey': 'B30AB604-36A8-4DAB-AC4C-EAFBB1A42FC0',
    });
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return JsonDecoder().convert(response.body)['rate'];
    }
    return 0.0;
  }
}
