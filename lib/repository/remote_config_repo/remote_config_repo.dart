import 'package:dualarim/model/waktu_sholat/waktu_sholat_model.dart';
import 'package:dualarim/util/check_time.dart';

class RemoteConfigRepo {
  final checkTime = new CheckTime();

  Future<WaktuSholatModel> getWaktuSholat(String value) =>
      checkTime.getWaktuSholat(value);
}
