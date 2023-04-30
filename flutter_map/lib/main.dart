import 'package:flutter/material.dart';
import 'package:flutter_map/src/map_key.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google Office Locations'),
          backgroundColor: Colors.green[700],
        ),
        body: const MapContainer(),
      ),
    );
  }
}

class MapContainer extends StatefulWidget {
  const MapContainer({Key? key}) : super(key: key);

  @override
  State<MapContainer> createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  final PolylinePoints _polylinePoints = PolylinePoints();
  GoogleMapController? _mapController;
  final Map<String, Marker> _markers = {};
  final Map<PolylineId, Polyline> _polyLines = {};
  final List<LatLng> _polylineCoordinates = [];
  final LatLng targetPosition = const LatLng(0, 0);
  final double minZoom = 3.0;
  final double maxZoom = 12.0;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            minMaxZoomPreference: MinMaxZoomPreference(minZoom, maxZoom),
            mapType: MapType.normal,
            polylines: Set<Polyline>.of(_polyLines.values),
            initialCameraPosition: CameraPosition(
              target: targetPosition,
              zoom: minZoom,
            ),
            markers: _markers.values.toSet(),
          ),
          Positioned(
            left: 16.0,
            bottom: 128.0,
            child: ElevatedButton(
              onPressed: () {
                makeLines();
              },
              child: const Text('路線：馬德里 - 里斯本'),
            ),
          ),
          Positioned(
            left: 16.0,
            bottom: 72.0,
            child: ElevatedButton(
              onPressed: () {
                var position = _markers['馬德里']?.position;
                if(position == null) return;
                moveTo(position, 19);
              },
              child: const Text('放大至馬德里'),
            ),
          ),
          Positioned(
            left: 16.0,
            bottom: 16.0,
            child: ElevatedButton(
              onPressed: () {
                moveTo(targetPosition, minZoom);
                clearPolyLines();
              },
              child: const Text('還原'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _mapController = controller;
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  void makeLines() async {
    if(_polylineCoordinates.isNotEmpty) return;
    var position1 = _markers['里斯本']?.position;
    var position2 = _markers['馬德里']?.position;
    if (position1 == null || position2 == null) return;

    await _polylinePoints
        .getRouteBetweenCoordinates(
      googleMapsKey,
      PointLatLng(position1.latitude, position1.longitude), //Starting LATLANG
      PointLatLng(position2.latitude, position2.longitude), //End LATLANG
      travelMode: TravelMode.driving,
      avoidHighways: true,
    )
        .then((value) {
      value.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }).then((value) {
      addPolyLine();
    });
  }

  void addPolyLine() {
    PolylineId id = const PolylineId("test_poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.lightBlue, points: _polylineCoordinates);
    _polyLines[id] = polyline;
    setState(() {});
  }

  void moveTo(LatLng latLng, double zoomValue) {
    final positionWithZoom = CameraPosition(target: latLng, zoom: zoomValue);
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(positionWithZoom),
    );
  }

  void clearPolyLines() {
    setState(() {
      _polylineCoordinates.clear();
      _polyLines.clear();
    });
  }
}
