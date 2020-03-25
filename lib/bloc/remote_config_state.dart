part of 'remote_config_bloc.dart';

abstract class RemoteConfigState extends Equatable {
  RemoteConfigState([List props = const []]) : super(props);
}

class RemoteConfigStateEmpty extends RemoteConfigState {}

class RemoteConfigStateLoading extends RemoteConfigState {}

class RemoteConfigStateLoaded extends RemoteConfigState {
  final WaktuSholatModel waktuSholatModel;

  RemoteConfigStateLoaded({@required this.waktuSholatModel})
      : assert(waktuSholatModel != null);
}

class RemoteConfigStateError extends RemoteConfigState {}
