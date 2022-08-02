import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSingleton {


  static final String accessToken = "access_token";
  static final String startedPageWasSeen = "started_page_was_seen";
  static final String patientID = "patient_id";
  static final String lastAppointmentRequestDate = "last_appointment_request_date";


// save data functions
  addStringToSF(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  addIntToSF(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  addDoubleToSF(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  addBoolToSF(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  getStringValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String? stringValue = prefs.getString(key);
    print('Shared preference value: ' + stringValue.toString());
    return stringValue;
  }

// read data functions
  getBoolValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    return prefs.getBool(key);
  }

  getIntValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int? intValue = prefs.getInt(key);
    return intValue;
  }

  getDoubleValuesSF(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    double? doubleValue = prefs.getDouble(key);
    return doubleValue;
  }

//remove data
  removeValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove value
    prefs.remove(key);
  }

  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    SharedPreferencesSingleton().addBoolToSF(SharedPreferencesSingleton.startedPageWasSeen, true);
  }
}
