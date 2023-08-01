import 'package:flutter/material.dart';
import '../services/coin_data.dart';
import 'dart:io' show Platform;
import '../components/custom_card.dart';
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

  String exchangeRateBTC = '';

  void updateUI(var exchangeData, currency) {
    if (exchangeData == null) {
      setState(() {
        selectedCurrency = currency;
        exchangeRateBTC = 'ERROR';
      });

      return;
    }

    double rate = exchangeData['rate'];
    setState(() {
      selectedCurrency = currency;
      exchangeRateBTC = rate.toStringAsFixed(2);
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
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: CustomCard(
              exchangeRateBTC: exchangeRateBTC,
              selectedCurrency: selectedCurrency,
              cryptoCurrencyType: 'BTC',
            ),
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
