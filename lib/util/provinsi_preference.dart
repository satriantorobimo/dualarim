import 'package:shared_preferences/shared_preferences.dart';

class ProvinsiPreference {
  static const PROVINSI = "PROVINSI";

  setProvinsi(String provinsi) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Provinsi Shared : $provinsi');
    prefs.setString(PROVINSI, provinsi);
  }

  Future<String> getProvinsi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('PROVINSI');
    return value;
  }
}
