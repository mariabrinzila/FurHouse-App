import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Location {
  Future<String> toggleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return "disabled";
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.deniedForever) {
        return "denied-forever";
      }

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return "denied";
        }
      }

      return "permitted";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    String location = "";

    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      location =
          '${place.street}, ${place.locality}, ${place.country}, ${place.postalCode}';
    }).catchError((e) {
      location = "error:${e.toString()}";
    });

    return location;
  }
}
