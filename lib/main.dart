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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text('teste')
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
          ItensTransfers(Transfer(100.0, 1001)),
          ItensTransfers(Transfer(200.0, 1001)),
          ItensTransfers(Transfer(300.0, 3003)),
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
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);
}