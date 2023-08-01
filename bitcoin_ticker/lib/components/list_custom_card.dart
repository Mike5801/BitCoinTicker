import 'package:flutter/material.dart';
import '../services/coin_data.dart';
import 'custom_card.dart';

List<Padding> getExchangeRateCards(
    Map<String, dynamic> exchangeRates, String selectedCurrency) {
  List<Padding> exchangeRateCards = [];

  for (String crypto in cryptoList) {
    exchangeRateCards.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: CustomCard(
          exchangeRate: exchangeRates[crypto].toString(),
          selectedCurrency: selectedCurrency,
          cryptoCurrencyType: crypto,
        ),
      ),
    );
  }

  return exchangeRateCards;
}
