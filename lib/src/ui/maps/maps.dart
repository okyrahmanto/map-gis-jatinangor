import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gis_jatinangor/src/ui//maps/maps_bloc.dart';
import 'package:latlong/latlong.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  MapsBloc _mapsBloc;
  @override
  void initState() {
    _mapsBloc = MapsBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('GIS Jatinangor')),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            /*StreamBuilder(
                stream: _mapsBloc.getPosition,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: Text('loading..'));
                  } else {
                    return Center(
                        child: Text('${snapshot.data.latitude.toString()}'));
                  }
                }),*/
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).padding.top -
                      kToolbarHeight,
                  child: maps(_mapsBloc),
                ),
                toolbar(_mapsBloc),
              ],
            ),
            /*Flexible(
              child: FlutterMap(
                mapController: _mapsBloc.getMapController,
                options: MapOptions(
                  center: LatLng(-6.930938, 107.774967),
                  zoom: 6.0,
                  interactive: true,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "http://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
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

                  new MarkerLayerOptions(
                    markers: [
                      new Marker(
                        width: 80.0,
                        height: 80.0,
                        point: new LatLng(-6.930938, 107.774967),
                        builder: (ctx) => new Container(
                          child: new FlutterLogo(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          */
          ],
        ),
      ),
    );
  }
}

Widget maps(_mapsBloc) {
  return Column(
    children: <Widget>[
      Flexible(
          child: StreamBuilder(
        stream: _mapsBloc.getPosition,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: Text('loading..'));
          } else {
            return FlutterMap(
              mapController: _mapsBloc.getMapController,
              options: MapOptions(
                center: LatLng(snapshot.data.latitude, snapshot.data.longitude),
                zoom: 6.0,
                onTap: (point) => print('$snapshot.data.latitude' '$snapshot.data.longitude'),
                onLongPress: (point) => print(point),
                onPositionChanged: (position, hasGesture) => print("$position $hasGesture"),
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "http://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                
              
                /*TileLayerOptions(
                      wmsOptions: WMSTileLayerOptions(
                    baseUrl: 'http://maps.heigit.org/osm-wms/service?',
                    layers: ['europe_wms:hs_srtm_europa'],
                      //baseUrl: 'http://www.kk-insig.org:8090/geoserver/sayang/wms?',
                    //version: '1.1.0',
                     // layers: ['sayang:sayang-utm05m'],
                    //format: 'image/png',
                    )
                  ),*/
                  MarkerLayerOptions(markers: _mapsBloc.getStatefulMapController.markers),
              ],
            );
          }
        },
      ))
    ],
  );
}

Widget toolbar(_mapsBloc) {
  return Align(
    alignment: Alignment.topRight,
    child: Container(
      height: 150.0,
      width: 60.0,
      child: Column(children: <Widget>[
        IconButton(
            iconSize: 30.0,
            color: Colors.blueGrey,
            icon: const Icon(Icons.zoom_out),
            tooltip: "Zoom out",
            onPressed: _mapsBloc.zoomOut),
        IconButton(
            iconSize: 30.0,
            color: Colors.blueGrey,
            icon: const Icon(Icons.zoom_in),
            tooltip: "Zoom in",
            onPressed: _mapsBloc.zoomIn),
        IconButton(
            iconSize: 30.0,
            color: Colors.blueGrey,
            icon: const Icon(Icons.center_focus_strong),
            tooltip: "Center",
            onPressed: _mapsBloc.centerOnLiveMarker)
      ]),
    ),
  );
}
