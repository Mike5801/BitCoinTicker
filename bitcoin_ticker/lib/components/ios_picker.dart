import 'package:flutter/cupertino.dart';
import '../services/coin_data.dart';

CupertinoPicker iOSPicker(
    String selectedCurrency, CoinData coinData, Function updateUI) {
  List<Text> pickerItems = [];

  for (String currency in currenciesList) {
    pickerItems.add(Text(currency));
  }

  return CupertinoPicker(
    itemExtent: 32.0,
    onSelectedItemChanged: (selectedIndex) async {
      selectedCurrency = currenciesList[selectedIndex].toString();
      Map<String, dynamic> exchangeDataMap = {};
      for(String crypto in cryptoList) {
        var exchangeData = await coinData.getCryptoExchange(selectedCurrency, crypto);
        exchangeDataMap.putIfAbsent(crypto, () => exchangeData);
      }

      updateUI(exchangeDataMap, selectedCurrency);
    },
    children: pickerItems,
  );
}
