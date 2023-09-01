import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'network_calls.dart';

String apiKey = '0FF4B2AA-9A97-4EFD-9CEC-A0B3FFAD45A5';
String bitCoinUrl = 'https://rest.coinapi.io/v1/exchangerate/BTC/';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  double BTCCurrency = 0;
  double ETHCurrency = 0;
  double LTCCurrency = 0;
  String vrCoin = 'BTC';
  String? SelectedCurrency = 'USD';

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropdownMenuItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownMenuItems.add(item);
    }
    return DropdownButton<String>(
      value: SelectedCurrency,
      items: dropdownMenuItems,
      onChanged: (value) {
        setState(() {
          SelectedCurrency = value;
        });
        getBitCoin('BTC');
        getBitCoin('ETH');
        getBitCoin('LTC');
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> dropdownMenuItems = [];
    for (String currency in currenciesList) {
      var item = Text(currency); //can be skipped
      dropdownMenuItems.add(item);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: dropdownMenuItems,
    );
  }

  void getBitCoin(String coin) async {
    Uri url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$coin/$SelectedCurrency?apiKey=$apiKey');
    NetwrokCall netwrokCall = NetwrokCall(url);
    try {
      var response = await netwrokCall.callApi();
      // print('coin = $coin please $response');
      setState(() {
        if (coin == 'BTC') {
          setState(() {
            BTCCurrency = response['rate'];
          });
        } else if (coin == 'ETH') {
          setState(() {
            ETHCurrency = response['rate'];
          });
        } else if (coin == 'LTC') {
          setState(() {
            LTCCurrency = response['rate'];
          });
        }
      });


    } catch (e) {
      print(e);
      setState(() {
        BTCCurrency = 429;
        ETHCurrency = 429;
        LTCCurrency = 429;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBitCoin('BTC');
    getBitCoin('ETH');
    getBitCoin('LTC');
  }

  @override
  Widget build(BuildContext context) {
    // getBitCoin();
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
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
                  '1 BTC = $BTCCurrency $SelectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
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
                  '1 ETH = $ETHCurrency $SelectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
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
                  '1 LTC = $LTCCurrency $SelectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
