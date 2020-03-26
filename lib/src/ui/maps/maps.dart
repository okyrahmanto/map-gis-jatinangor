import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class WMSLayerPage extends StatelessWidget {
  static const String route = 'WMS layer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WMS Layer')),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(-6.930938, 107.774967),
                  zoom: 6.0,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate: "http://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  /*TileLayerOptions(
                      wmsOptions: WMSTileLayerOptions(
                    //baseUrl: 'http://maps.heigit.org/osm-wms/service?',
                    //layers: ['europe_wms:hs_srtm_europa'],
                      baseUrl: 'http://www.kk-insig.org:8090/geoserver/sayang/wms?',
                    //version: '1.1.0',
                      layers: ['sayang:sayang-utm05m'],
                    //format: 'image/png',
                    )
                  )*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}