import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//import 'package:google_maps_webservice/distance.dart';
class MapProvider with ChangeNotifier {
  var _initialPosition;
  var _lastPosition;
  var googleAPIKey = "AIzaSyCKHhU_vGRvfk99jH9BikS1hUtv7HRMK5I";

  bool isLatLngRequired = true;
  bool onMapVisibilty = true;
  bool _drive = false;

  bool get drive => _drive;

  bool locationServiceActive = true;

  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;

  GoogleMapController? _mapController;

  final Set<Marker> _routingmarkers = {};

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};

  final locationController = TextEditingController();
  final destinationController = TextEditingController();

  GoogleMapController get mapController => _mapController!;

  Set<Marker> get markers => _markers;

  Set<Polyline> get polyLines => _polyLines;
  MapProvider() {
    _getUserLocation();
    _loadingInitialPosition();
  }
// ! TO GET THE USERS LOCATION
  void _getUserLocation() async {
    print("GET POSITION");
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

//After permission is agreed

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      _initialPosition = LatLng(position.latitude, position.longitude);
      locationController.text = placemark[0].name!;
      String add = placemark[0].country!;
      notifyListeners();
    } catch (e) {
      _initialPosition = LatLng(position.latitude, position.longitude);
      locationController.text = "Current Location";
      notifyListeners();
    }
  }

// // ! On create zoom to consider all points
// void zoomout(List<AddStop> _stop) async {
// // Accommodate the two locations within the
// // camera view of the map
//   mapController2.animateCamera(
//     CameraUpdate.newLatLngBounds(
//         LatLngBounds(
//             southwest: LatLng(
//                 _stop[0].position!.latitude <= _stop.last.position!.latitude
//                     ? _stop[0].position!.latitude
//                     : _stop.last.position!.latitude,
//                 _stop[0].position!.longitude <= _stop.last.position!.longitude
//                     ? _stop[0].position!.longitude
//                     : _stop.last.position!.longitude),
//             northeast: LatLng(
//                 _stop[0].position!.latitude <= _stop.last.position!.latitude
//                     ? _stop.last.position!.latitude
//                     : _stop[0].position!.latitude,
//                 _stop[0].position!.longitude <= _stop.last.position!.longitude
//                     ? _stop.last.position!.longitude
//                     : _stop[0].position!.longitude)),
//         50),
//   );

//   notifyListeners();
// }

// ! ADD A MARKER ON THE MAO
  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        infoWindow: InfoWindow(title: address, snippet: "go here"),
        icon: BitmapDescriptor.defaultMarker));
    notifyListeners();
  }

// ! ADD A MARKER ON THE ROUTE
  void addMarkerRouting(LatLng location) {
    _routingmarkers.add(Marker(
        markerId: MarkerId(_lastPosition.toString()),
        position: location,
        icon: BitmapDescriptor.defaultMarker));
    notifyListeners();
  }

// ! ON CAMERA MOVE
  void onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
    notifyListeners();
  }

// ! ON CREATE
  void onCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

//  LOADING INITIAL POSITION
  void _loadingInitialPosition() async {
    await Future.delayed(Duration(seconds: 5)).then((v) {
      if (_initialPosition == null) {
        locationServiceActive = false;
        notifyListeners();
      }
    });
  }
}
