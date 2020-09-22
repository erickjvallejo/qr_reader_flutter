import 'package:flutter/widgets.dart';
import 'package:qrreaderapp/src/model/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

openScan(BuildContext context, ScanModel scan) async {
  if (scan.type == 'http') {
    if (await canLaunch(scan.value)) {
      await launch(scan.value);
    } else {
      throw 'Could not launch $scan.value)';
    }
  } else {
    Navigator.pushNamed(context, 'maps' , arguments: scan);


  }
}
