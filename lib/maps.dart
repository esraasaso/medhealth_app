import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medhealth/main_page.dart';
import 'dart:async';

import 'package:medhealth/screens/home.dart';
import 'package:medhealth/screens/register_screen.dart';
import 'package:medhealth/theme.dart';


class Myhome extends StatefulWidget {
  const Myhome({super.key});
  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  String locationMessage ="current location of user";
  var lat;
 var long;
 late Position cl;

 late CameraPosition _kGooglePlex;

 Future getCurrentLocation() async {
   bool serviceEnabled =await Geolocator.isLocationServiceEnabled();
   if(!serviceEnabled){
     return Future.error("Location are disabled");
   }
   LocationPermission permission =await Geolocator.checkPermission();
   if(permission==LocationPermission.denied){
     permission=await Geolocator.requestPermission();
   }
   print("-------------");
   print(permission);
   print("--------------");
   return permission;

   // return await Geolocator.getCurrentPosition();
 }

  Future<void> getLatAndLong() async{
   cl= await Geolocator.getCurrentPosition().then((value) => value);
   lat=cl.latitude;
   long=cl.longitude;
   _kGooglePlex = CameraPosition(
     target: LatLng(lat, long),
     zoom: 14.4746,
   );
   setState(() {

   });
  }
  @override
  void initState(){
   getCurrentLocation();
   getLatAndLong();
   super.initState();
  }
  final Completer<GoogleMapController> _controller = Completer();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 100,
                    child: Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "ENTER YOUR LOCATION",
                              suffixIcon: Icon(Icons.search),
                              contentPadding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          )),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      child: ElevatedButton(
                        child: Text('Save',style: regulerTextstyle.copyWith(fontSize: 20,color: whiteColor)),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>MainPages()));
                        },
                      )),
                )
              ],
            ),
          )),
    );
  }
}
