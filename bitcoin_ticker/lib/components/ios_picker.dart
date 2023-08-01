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
      var exchangeData =
          await coinData.getCryptoExchange(selectedCurrency, 'BTC');
      updateUI(exchangeData, selectedCurrency);
    },
    children: pickerItems,
  );
}
