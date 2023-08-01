import 'dart:convert';

import 'package:http/http.dart' as http;
import '../services/keys.dart';

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
  // https://rest.coinapi.io/v1/exchangerate/BTC/USD
  final String _baseURL = 'rest.coinapi.io';
  String _exchangeCoin = "";
  String _cryptoCurrency = "";

  Future<dynamic> getCryptoExchange(
      String exchangeCoin, String cryptoCurrency) async {
    _exchangeCoin = exchangeCoin;
    _cryptoCurrency = cryptoCurrency;

    Uri url =
        Uri.https(_baseURL, '/v1/exchangerate/$_cryptoCurrency/$_exchangeCoin');

    http.Response response =
        await http.get(url, headers: {"X-CoinAPI-Key": kApiKey});

    var cryptoData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return cryptoData;
    } else {
      print('Status Code: ${response.statusCode} | Error ${cryptoData["error"]}');
      return null;
    }
  }
}
