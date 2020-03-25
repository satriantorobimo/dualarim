part of 'remote_config_bloc.dart';

abstract class RemoteConfigEvent extends Equatable {
  RemoteConfigEvent([List props = const []]) : super(props);
}

class FetchWaktuSholat extends RemoteConfigEvent {
  final String value;

  FetchWaktuSholat({@required this.value}) : assert(value != null);
}
