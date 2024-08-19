import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  String? selectedCurrency = 'USD';
  Map<String, double>? prices = {};

  List<Widget> getCryptoList() {
    List<Widget> cryptoWidgets = [];
    for (String crypto in cryptoList) {
      cryptoWidgets.add(Padding(
        padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $crypto = ${prices?[crypto] == null ? '?' : prices?[crypto]?.toStringAsFixed(2)} $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ));
    }
    return cryptoWidgets;
  }

  void upDateUI() async {
    Map<String, double> newPrices = {};
    for (String crypto in cryptoList) {
      newPrices[crypto] =
          await coinData.getCoinData(crypto, selectedCurrency ?? "");

    }
    prices = newPrices;
  }

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> dropDownItemsList = [];
    for (String currency in currenciesList) {
      dropDownItemsList.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItemsList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          upDateUI();
        });
      },
    );
  }

  CupertinoPicker getCupertinoPicker() {
    List<Text> textItems = [];
    for (String currency in currenciesList) {
      textItems.add(Text(currency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          upDateUI();
        });
      },
      children: textItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getCryptoList(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:
                Platform.isAndroid ? getDropDownButton() : getCupertinoPicker(),
          ),
        ],
      ),
    );
  }
}
