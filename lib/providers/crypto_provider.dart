import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/crypto_model.dart';

class CryptoProvider with ChangeNotifier {
  List<Crypto> _cryptos = [];

  List<Crypto> get cryptos => _cryptos;

  Future<void> fetchCryptos() async {
    final url = 'https://api.coinlore.net/api/tickers/';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<Crypto> loadedCryptos = [];
        for (var cryptoData in data['data']) {
          loadedCryptos.add(Crypto.fromJson(cryptoData));
        }
        _cryptos = loadedCryptos;
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      throw error;
    }
  }
}
