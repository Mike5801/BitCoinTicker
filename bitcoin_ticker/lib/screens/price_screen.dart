import 'package:flutter/material.dart';
import '../services/coin_data.dart';
import 'dart:io' show Platform;
import '../components/list_custom_card.dart';
import '../components/android_dropdown.dart';
import '../components/ios_picker.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  CoinData coinData = CoinData();

  Map<String, String> exchangeRates = {};

  @override
  void initState() {
    super.initState();
    for (String crypto in cryptoList) {
      exchangeRates.putIfAbsent(crypto, () => '...');
    }
    getInitialExchangeCurrency();
  }

  void getInitialExchangeCurrency() async {
    Map<String, dynamic> futureExchangeData = {};
    for (String crypto in cryptoList) {
      futureExchangeData[crypto] = await coinData.getCryptoExchange(selectedCurrency, crypto);
    }

    futureExchangeData.removeWhere((key, value) => value == null);

    if (futureExchangeData.isEmpty) {
      updateUI(null, selectedCurrency);
      return;
    }

    updateUI(futureExchangeData, selectedCurrency);
  }

  void updateUI(var exchangeData, String currency) {
    setState(() {
      selectedCurrency = currency;
      for (String crypto in cryptoList) {
        if (exchangeData[crypto] == null) {
          exchangeRates[crypto] = 'ERROR';
          continue;
        }
        String formattedExchangeRate =
            exchangeData[crypto]['rate'].toStringAsFixed(2);

        exchangeRates[crypto] = formattedExchangeRate;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getExchangeRateCards(exchangeRates, selectedCurrency),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? iOSPicker(selectedCurrency, coinData, updateUI)
                : androidDropdown(selectedCurrency, coinData, updateUI),
          ),
        ],
      ),
    );
  }
}
