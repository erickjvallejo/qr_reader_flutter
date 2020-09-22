import 'dart:async';

import 'package:qrreaderapp/src/bloc/validator.dart';
import 'package:qrreaderapp/src/model/scan_model.dart';
import 'package:qrreaderapp/src/provider/db_provider.dart';

class ScansBloc with Validators {
  static final ScansBloc _singleton = new ScansBloc._private();

  factory ScansBloc() {
    return _singleton;
  }

  //Get Scans of DB
  ScansBloc._private() {
    getScans();
  }

  final _scanStreamController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStreamGeo =>
      _scanStreamController.stream.transform(validateGeo);

  Stream<List<ScanModel>> get scansStreamHttp =>
      _scanStreamController.stream.transform(validateHttp);

  dispose() {
    _scanStreamController?.close();
  }

  addScan(ScanModel scan) async {
    await DBProvider.db.newScan(scan);
    getScans();
  }

  getScans() async {
    _scanStreamController.sink.add(await DBProvider.db.getAllScans());
  }

  deleteScam(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans(); //Way number 1
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAllScan();
    _scanStreamController.sink.add([]); //Another way (number 2)
  }
}
