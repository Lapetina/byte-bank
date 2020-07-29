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
        body: ListTransfers(),
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
      body: ListView(
        children: <Widget>[
          Edit(
              controller: _controlAccountNumber,
              label: 'Número da conta',
              tip: '0000'
          ),
          Edit(
            controller: _controlValue,
            label: 'Valor',
            tip: '0.00',
            icon: Icons.monetization_on,
          ),
          RaisedButton(
            child: Text('Confirmar'),
            onPressed: () {
              _createTransfer(context);
            },
          )
        ],
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int accountNumber = int.tryParse(
        _controlAccountNumber.text);
    final double valueNumber = double.tryParse(_controlValue.text);
    if (accountNumber != null && valueNumber != null) {
      final transfer = Transfer(accountNumber, valueNumber);
      Navigator.pop(context, transfer);
//      final snackBar = SnackBar(content: Text('$transfer'));
//      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}

class Edit extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String tip;
  final IconData icon;

  Edit({this.controller, this.label, this.tip, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextField(
        style: TextStyle(
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
            labelText: label,
            hintText: tip,
            icon: icon != null ? Icon(icon) : null,
        ),
        keyboardType: TextInputType.number,
        controller: controller,
      ),
    );
  }
}


class ListTransfers extends StatefulWidget{
  final List<Transfer> _transfer = List();

  @override
  State<StatefulWidget> createState() {
    return ListTransferState();
  }
}

class ListTransferState extends State<ListTransfers> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: widget._transfer.length,
        itemBuilder: (context, index) {
          final transfer = widget._transfer[index];
          return ItensTransfers(transfer);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add), onPressed: () {
        final Future<Transfer> future = Navigator.push(context, MaterialPageRoute(builder: (context) {
          return FormTransfer();
        }),
        );
        future.then((transferReciver){
          setState(() {
            widget._transfer.add(transferReciver);
          });
          debugPrint('$transferReciver');

        });
      },
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