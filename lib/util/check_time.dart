import 'dart:convert';

import 'package:dualarim/model/waktu_sholat/waktu_sholat_model.dart';
import 'package:intl/intl.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class CheckTime {
  static DateTime now = DateTime.now();
  static String formattedDate = DateFormat('kkmm').format(now);
  List<WaktuSholatModel> waktuSholatModel;
  int lastTime = 0;
  int count = 0;

  Future<WaktuSholatModel> getWaktuSholat(String value) async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings(debugMode: true));
    String provinsi = value;
    print('Provinsi Remote : $provinsi');
    await remoteConfig.fetch();
    await remoteConfig.activateFetched();
    var res = json.decode(remoteConfig.getString(provinsi));
    waktuSholatModel =
        (res as List).map((i) => WaktuSholatModel.fromJson(i)).toList();
    for (int i = 0; i < waktuSholatModel.length; i++) {
      int server = int.parse(waktuSholatModel[i].waktu);
      int now = int.parse(formattedDate);
      if (lastTime != 0) {
        if (now > lastTime && now < server) {
          count = i;
          break;
        }
        lastTime = server;
      } else {
        lastTime = server;
      }
    }
    return waktuSholatModel[count];
  }
}
