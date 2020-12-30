import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DetailPage extends StatefulWidget {
  final BluetoothDevice server;

  const DetailPage({this.server});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  BluetoothConnection connection;
  bool isConnecting = true;

  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    _getBTConnection();
  }

  @override
  void dispose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    super.dispose();
  }

  _getBTConnection() {
    BluetoothConnection.toAddress(widget.server.address).then(
      (_connection) {
        connection = _connection;
        isConnecting = false;
        isDisconnecting = false;

        setState(() {});

        connection.input.listen(_onDataReceived).onDone(() {
          if (isDisconnecting) {
            print(' disconnecting local');
          } else {
            print(' disconnecting remote');
          }

          if (this.mounted) {
            setState(() {});
          }

          Navigator.of(context).pop();
        });
      },
    ).catchError((error) {
      Navigator.of(context).pop();
    });
  }

  _onDataReceived(Uint8List data) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mediciones'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            (isConnecting
                ? Text('Conectando ${widget.server.name}...')
                : isConnected
                    ? Text('Conectado ${widget.server.name}')
                    : Text('Desconectado ${widget.server.name}')),
          ],
        ),
      ),
    );
  }
}
