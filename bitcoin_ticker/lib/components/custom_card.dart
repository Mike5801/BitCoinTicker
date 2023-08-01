import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.exchangeRate,
    required this.selectedCurrency,
    required this.cryptoCurrencyType
  });

  final String exchangeRate;
  final String selectedCurrency;
  final String cryptoCurrencyType;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $cryptoCurrencyType = $exchangeRate $selectedCurrency',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
