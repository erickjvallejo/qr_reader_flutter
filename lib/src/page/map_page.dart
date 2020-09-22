import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/model/scan_model.dart';

import 'package:qrreaderapp/src/utils/utils.dart' as utils;

class MapPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.getScans();

    return StreamBuilder(
        stream: scansBloc.scansStreamGeo,
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snaphot) {
          if (!snaphot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final scans = snaphot.data;

          if (scans.length == 0) {
            return Center(
              child: Text('There is not info to show'),
            );
          }

          return ListView.builder(
              itemCount: scans.length,
              itemBuilder: (context, i) => Dismissible(
                    direction: DismissDirection.endToStart,
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (direction) =>
                        scansBloc.deleteScam(scans[i].id),
                    child: ListTile(
                        leading: Icon(
                          Icons.map,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(scans[i].value),
                        subtitle: Text(' Id : ${scans[i].id}'),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.red,
                        ),
                        onTap: () => utils.openScan(context, scans[i])),
                  ));
        });
  }
}
