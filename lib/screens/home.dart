import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:jitney_userSide/helpers/constants.dart';
import 'package:jitney_userSide/helpers/style.dart';
import 'package:jitney_userSide/providers/app.dart';
import "package:google_maps_webservice/places.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jitney_userSide/helpers/navigation.dart';
import 'package:jitney_userSide/providers/user.dart';
import 'package:jitney_userSide/widgets/custom_txt.dart';
import 'package:jitney_userSide/widgets/destination_selection.dart';
import 'package:jitney_userSide/widgets/driver_found.dart';
import 'package:jitney_userSide/widgets/loading.dart';
import 'package:jitney_userSide/widgets/payment_method_selection.dart';
import 'package:jitney_userSide/widgets/pickup_selection_widget.dart';
import 'package:jitney_userSide/widgets/trip_draggable.dart';
import 'login.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _deviceToken();
  }

  _deviceToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    UserProvider _user = Provider.of<UserProvider>(context, listen: false);

    if (_user.userModel?.token != preferences.getString('token')) {
      Provider.of<UserProvider>(context, listen: false).saveDeviceToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    AppProvider appState = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Scaffold(
          key: scaffoldState,
          drawer: Drawer(
            child: ListView(
          children: [
            UserAccountsDrawerHeader(
                accountName: CustomText(
                  text: userProvider.userModel?.name ?? "This is null",
                  size: 18,
                  weight: FontWeight.bold,
                ),
                accountEmail: CustomText(
                  text: userProvider.userModel?.email ?? "This is null",
                )),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: CustomText(text: "Log out"),
              onTap: () {
                userProvider.signOut();
                changeScreenReplacement(context, LoginScreen());
              },
            )
          ],
        )),
          body: Stack(
          children: [
            Map(scaffoldState),
            Visibility(
              visible: appState.show == Show.DRIVER_FOUND,
              child: Positioned(
                  top: 60,
                  left: 15,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: appState.driverArrived ? Container(
                            color: Colors.green,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: CustomText(
                                text: "Meet driver at the pick up location",
                                color: Colors.white,
                              ),
                            ),
                          ) : Container(
                            color: Primary,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: CustomText(
                                text: "Meet driver at the pick up location",
                                weight: FontWeight.w300,
                                color: white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            Visibility(
              visible: appState.show == Show.TRIP,
              child: Positioned(
                  top: 60,
                  left: MediaQuery.of(context).size.width / 7,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Container(
                            color: Primary,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: RichText(text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "You\'ll reach your destination in \n",
                                    style: TextStyle(fontWeight: FontWeight.w300)
                                  ),
                                  TextSpan(
                                      text: appState.routeModel?.timeNeeded?.text ?? "",
                                      style: TextStyle(fontSize: 22)
                                  ),
                                ]
                              ))
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            // ANCHOR Draggable
            Visibility(
                visible: appState.show == Show.DESTINATION_SELECTION,
                child: DestinationSelectionWidget()),
            // ANCHOR PICK UP WIDGET
            Visibility(
              visible: appState.show == Show.PICKUP_SELECTION,
              child: PickupSelectionWidget(
                scaffoldState: scaffoldState,
              ),
            ),
            //  ANCHOR Draggable PAYMENT METHOD
            Visibility(
                visible: appState.show == Show.PAYMENT_METHOD_SELECTION,
                child: PaymentMethodSelectionWidget(
                  scaffoldState: scaffoldState,
                )),
            //  ANCHOR Draggable DRIVER
            Visibility(
                visible: appState.show == Show.DRIVER_FOUND,
                child: DriverFoundWidget()),

            //  ANCHOR Draggable DRIVER
            Visibility(
                visible: appState.show == Show.TRIP,
                child: TripWidget()),
          ],
        ),
    ));
  }
}

class Map extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldState;

  Map(this.scaffoldState);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapsPlaces googlePlaces;
  TextEditingController destinationController = TextEditingController();
  Color darkBlue = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appState = Provider.of<AppProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return appState.center == null
        ? Loading()
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                CameraPosition(target: appState.center, zoom: 15),
                onMapCreated: appState.onCreate,
                myLocationEnabled: true,
                mapType: MapType.normal,
                compassEnabled: true,
                rotateGesturesEnabled: true,
                markers: appState.markers,
                onCameraMove: appState.onCameraMove,
                polylines: appState.poly,
              ),
              Positioned(
                top: 10,
                left: 15,
                child: IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Primary,
                      size: 30,
                    ),
                    onPressed: () {
                      scaffoldSate.currentState.openDrawer();
                    }),
              ),
              /**
               * Positioned(
                top: 60.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 120.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x88999999),
                        offset: Offset(0, 5),
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        cursorColor: Colors.blue.shade900,
                        controller: appState.locationController,
                        decoration: InputDecoration(
                          icon: Container(
                            margin: EdgeInsets.only(left: 20, top: 5),
                            width: 10,
                            height: 10,
                            child: Icon(
                              Icons.location_on,
                              color: Primary,
                            ),
                          ),
                          hintText: "pick up",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextField(
                          onTap: ()async{
                            Prediction p = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: GOOGLE_MAPS_API_KEY,
                                mode: Mode.overlay, // Mode.fullscreen
                                language: "pt",
                                components: [new Component(Component.country, "mz")]);

//                            displayPrediction(p);
                            PlacesDetailsResponse detail =
                            await places.getDetailsByPlaceId(p.placeId);
                            double lat = detail.result.geometry.location.lat;
                            double lng = detail.result.geometry.location.lng;
                            LatLng coordinates = LatLng(lat, lng);
                            appState.sendRequest(coordinates: coordinates);
                          },
                          textInputAction: TextInputAction.go,
//                          onSubmitted: (value) {
//                            appState.sendRequest(intendedLocation: value);
//                          },
                          controller: destinationController,
                          cursorColor: Colors.blue.shade900,
                          decoration: InputDecoration(
                            icon: Container(
                              margin: EdgeInsets.only(left: 20, top: 5),
                              width: 10,
                              height: 10,
                              child: Icon(
                                Icons.local_taxi,
                                color: Primary,
                              ),
                            ),
                            hintText: "destination?",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                bottom: 60, right: 0, left: 0, height: 60,
                child: Visibility(
                  visible: appState.routeModel != null,
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0, right: 15.0),
                    child: Container(
                      color: Colors.white,
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                         FlatButton.icon(onPressed: (){}, icon: Icon(Icons.timer), label: Text("18 min")),
                          FlatButton.icon(onPressed: (){}, icon: Icon(Icons.attach_money), label: Text("15"))


                        ],
                      ),
                    ),
                  ),
                ),),
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Padding(
                    padding: const EdgeInsets.only(left:15.0, right: 15.0),
                    child: RaisedButton(onPressed: (){}, color: darkBlue,
                      child: Text("Confirm Booking", style: TextStyle(color: white, fontSize: 16),),),
                  ),
                ),)
                **** */
            ],
          );
  }
  

  Future<Null> displayPrediction(Prediction p) async {
       if (p != null) {
         PlacesDetailsResponse detail =
         await places.getDetailsByPlaceId(p.placeId);

         var placeId = p.placeId;
         double lat = detail.result.geometry.location.lat;
         double lng = detail.result.geometry.location.lng;

         var address = await Geocoder.local.findAddressesFromQuery(p.description);

         print(lat);
         print(lng);
       }
  }

}
