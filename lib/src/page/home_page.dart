import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/model/scan_model.dart';
import 'package:qrreaderapp/src/page/address_page.dart';
import 'package:qrreaderapp/src/page/map_page.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scanBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {
              scanBloc.deleteAllScans();
            },
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _createBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Maps')),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_location), title: Text('Address')),
      ],
    );
  }

  Widget _callPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return MapPage();
      case 1:
        return AddressPage();

      default:
        return MapPage();
    }
  }

  _scanQR(BuildContext context) async {

    // https://www.qrcode.es/es/generador-qr-code/
    // geo:40.71226322834574,-74.0053404851807

    String futureString = '';

    try {
      futureString = await BarcodeScanner.scan();

      if (futureString != null) {
        final scan = new ScanModel(value: futureString);
        scanBloc.addScan(scan);

        if (Platform.isIOS) {
          Future.delayed(Duration(milliseconds: 750), () {
            utils.openScan(context, scan);
          });
        } else {
          utils.openScan(context, scan);
        }
      }

    } catch (e) {
      futureString = e.toString();
      print('Error trying to scan: $futureString');
    }




  }
}
