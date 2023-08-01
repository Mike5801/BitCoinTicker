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
      Map<String, dynamic> exchangeDataMap = {};
      for(String crypto in cryptoList) {
        var exchangeData = await coinData.getCryptoExchange(selectedCurrency, crypto);
        exchangeDataMap.putIfAbsent(crypto, () => exchangeData);
      }

      updateUI(exchangeDataMap, selectedCurrency);
    },
  );
}
