import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ghioon_seller/Providers/MapProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class ViewOnMap extends StatefulWidget {
  const ViewOnMap({super.key});

  @override
  State<ViewOnMap> createState() => _ViewOnMapState();
}

class _ViewOnMapState extends State<ViewOnMap> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final appState = Provider.of<MapProvider>(context);
    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(10),
            child: false //appState.initialPosition == null
                ? Container(
                    color: Colors.green,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SpinKitWave(
                              color: Colors.white,
                              size: 50.0,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Visibility(
                          visible: appState.locationServiceActive == false,
                          child: Text(
                            "Waiting for current Location . . .",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ))
                : Stack(children: <Widget>[
                    GoogleMap(
                      mapType: MapType.normal,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      markers: appState.markers,
                      zoomControlsEnabled: false,
                      onMapCreated: appState.onCreated,
                      onCameraMove: appState.onCameraMove,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(8.9930104, 38.6725714),
                        // LatLng(appState.initialPosition.latitude,
                        //     appState.initialPosition.longitude),
                        zoom: 14,
                      ),
                    ),
                    Positioned(
                      bottom: height * 0.05,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          height: height * 0.12,
                          width: width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18.0),
                                  topRight: Radius.circular(18.0),
                                  bottomLeft: Radius.circular(18.0),
                                  bottomRight: Radius.circular(18.0)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 16.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(0.7, 0.7))
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(66, 0, 150, 135),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18.0)),
                                  ),
                                  width: width * 0.2,
                                  height: 10,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                                child: InkWell(
                                  onTap: () {
                                    // appState.removealladdress();
                                    // appState.addinit();
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             SearchPlace()));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 236, 232, 232),
                                      border: Border.all(
                                          color: Colors.teal, width: 3.0),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(18.0)),
                                    ),
                                    height: height * 0.06,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    child: Row(children: [
                                      Icon(
                                        Icons.location_pin,
                                        color: Colors.teal,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Where Do you want to Go?",
                                          style: TextStyle(
                                              color: Colors.teal,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold))
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ])));
  }
}
