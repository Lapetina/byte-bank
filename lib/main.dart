import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: ListTransfers(),
        appBar: AppBar(
          title: Text('Transferências'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
        ),
      ),
    )
  );
}

class ListTransfers extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItensTransfers(Transfer(100.0, 1001)),
        ItensTransfers(Transfer(200.0, 1001)),
        ItensTransfers(Transfer(300.0, 3003)),
      ],
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