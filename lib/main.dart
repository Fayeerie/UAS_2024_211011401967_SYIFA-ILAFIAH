import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/crypto_provider.dart';
import 'models/crypto_model.dart';

void main() {
  runApp(uasapp());
}

class uasapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CryptoProvider(),
      child: MaterialApp(
        title: 'Crypto Prices',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CryptoListScreen(),
      ),
    );
  }
}

class CryptoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Prices'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<CryptoProvider>(context, listen: false).fetchCryptos(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<CryptoProvider>(
              builder: (ctx, cryptoProvider, child) {
                return ListView.builder(
                  itemCount: cryptoProvider.cryptos.length,
                  itemBuilder: (ctx, index) {
                    Crypto crypto = cryptoProvider.cryptos[index];
                    return ListTile(
                      title: Text(crypto.name),
                      subtitle: Text(crypto.symbol),
                      trailing: Text('\$${crypto.priceUsd.toStringAsFixed(2)}'),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
