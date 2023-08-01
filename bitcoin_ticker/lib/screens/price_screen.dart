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
      exchangeRates.putIfAbsent(crypto, () => '');
    }
    getInitialExchangeCurrency();
  }

  void getInitialExchangeCurrency() async {
    for (String crypto in cryptoList) {
      var exchangeData = await coinData.getCryptoExchange(selectedCurrency, crypto);
      String formattedExchangeRate =
          exchangeData['rate'].toStringAsFixed(2);
      setState(() {
        exchangeRates[crypto] = formattedExchangeRate;
      });
    }
  }

  void updateUI(var exchangeData, String currency) {
    if (exchangeData == null) {
      setState(() {
        selectedCurrency = currency;
        exchangeRates.forEach((crypto, value) {
          crypto = 'ERROR';
        });
      });

      return;
    }

    setState(() {
      selectedCurrency = currency;
      for (String crypto in cryptoList) {
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
