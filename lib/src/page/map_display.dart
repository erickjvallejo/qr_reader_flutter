import 'package:flutter/material.dart';
import 'package:qrreaderapp/src/model/scan_model.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class MapDisplay extends StatefulWidget {
  @override
  _MapDisplayState createState() => _MapDisplayState();
}

class _MapDisplayState extends State<MapDisplay> {
  final MapController mapController = new MapController();
  String mapType = 'streets-v11';

  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapping QR'),
        actions: [
          IconButton(
              icon: Icon(Icons.my_location),
              onPressed: () {
                mapController.move(scan.getLatLng(), 15);
              })
        ],
      ),
      body: _createFlutterMap(scan),
      floatingActionButton: _createFloatingButton(context),
    );
  }

  Widget _createFlutterMap(ScanModel scan) {
    return new FlutterMap(
      mapController: mapController,
      options: MapOptions(center: scan.getLatLng(), zoom: 13.0),
      layers: [_createMap(), createMarkers(scan)],
    );
  }

  LayerOptions _createMap() {
    return TileLayerOptions(
        urlTemplate:
            "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
        subdomains: ['a', 'b', 'c'],
        maxZoom: 18,
        zoomOffset: -1,
        tileSize: 512,
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoiZXJpY2tqdmFsbGVqbyIsImEiOiJja2ZiYWEyeTIwZjlsMnlxeWJnZ2d2cG45In0.cGtVQLp_kUm6exA0N74Iig',
          'attribution':
              '© <a href="https://www.mapbox.com/about/maps/">Mapbox</a> © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> <strong><a href="https://www.mapbox.com/map-feedback/" target="_blank">Improve this map</a></strong>',
          'id': 'mapbox/${mapType}',
          //streets-v11 outdoors-V11 light-V10 dark-v10 satellite-v9 satellite-streets-v11
        });
  }

  MarkerLayerOptions createMarkers(ScanModel scan) {
    return MarkerLayerOptions(markers: [
      Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
                child: Icon(
                  Icons.location_on,
                  size: 70.0,
                  color: Theme.of(context).primaryColor,
                ),
              ))
    ]);
  }

  Widget _createFloatingButton(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.repeat),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          //streets-v11 outdoors-V11 light-V10 dark-v10 satellite-v9 satellite-streets-v11
          if (mapType == 'streets-v11') {
            mapType = 'outdoors-v11';
          } else if (mapType == 'outdoors-v11') {
            mapType = 'light-v10';
          } else if (mapType == 'light-v10') {
            mapType = 'dark-v10';
          } else if (mapType == 'dark-v10') {
            mapType = 'satellite-v9';
          } else if (mapType == 'satellite-v9') {
            mapType = 'satellite-streets-v11';
          } else {
            mapType = 'streets-v11';
          }

          //Todo: we need to review the update gui, it is not working
          setState(() {
            print('Changin Map Type to: ${mapType}');
          });

        });
  }
}
