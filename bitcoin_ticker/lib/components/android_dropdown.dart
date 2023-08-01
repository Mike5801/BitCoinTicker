import 'package:flutter/material.dart';
import '../services/coin_data.dart';

DropdownButton<String> androidDropdown(
    String selectedCurrency, CoinData coinData, Function updateUI) {
  List<DropdownMenuItem<String>> dropdownItems = [];
  for (String currency in currenciesList) {
    dropdownItems.add(
      DropdownMenuItem(
        value: currency,
        child: Text(currency),
      ),
    );
  }

  return DropdownButton<String>(
    value: selectedCurrency,
    items: dropdownItems,
    onChanged: (value) async {
      selectedCurrency = value.toString();
      var exchangeData =
          await coinData.getCryptoExchange(selectedCurrency, 'BTC');

      updateUI(exchangeData, selectedCurrency);
    },
  );
}
