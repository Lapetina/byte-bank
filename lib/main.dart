import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormTransfer(),
      ),
    );
  }
}


class FormTransfer extends StatelessWidget {
  final TextEditingController _controlAccountNumber = TextEditingController();
  final TextEditingController _controlValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                style: TextStyle(
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Número da conta',
                  hintText: '0000'
                ),
                keyboardType: TextInputType.number,
                controller: _controlAccountNumber,
              ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                style: TextStyle(
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  labelText: 'Valor',
                  hintText: '0.00',
                  icon: Icon(Icons.monetization_on),
                ),
                keyboardType: TextInputType.number,
                controller: _controlValue,
              ),
          ),
          RaisedButton(
            child: Text('Confirmar'),
            onPressed: () {
              debugPrint('cliclou no confirmar');
              final int accountNumber = int.tryParse(
                  _controlAccountNumber.text);
              final double valueNumber = double.tryParse(_controlValue.text);
              if (accountNumber != null && valueNumber != null) {
                final transfer = Transfer(accountNumber, valueNumber);
                print(accountNumber);
                print(valueNumber);
                debugPrint('$transfer');
                final snackBar = SnackBar(content: Text('$transfer'));
                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
          ),
        ],
      ),
    );
  }
}


class ListTransfers extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: [
          ItensTransfers(Transfer(1001, 100.0)),
          ItensTransfers(Transfer(1001, 200.0)),
          ItensTransfers(Transfer(3003, 300.0)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItensTransfers extends StatelessWidget {
  final Transfer _transfer;

  ItensTransfers(this._transfer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transfer.value.toString()),
        subtitle: Text(_transfer.accountNumber.toString()),
      ),
    );
  }
}

class Transfer {
  final int accountNumber;
  final double value;

  @override
  String toString() {
    return 'Transfer{accountNumber: $accountNumber, value: $value}';
  }

  Transfer(this.accountNumber, this.value);
}