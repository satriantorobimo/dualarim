import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dualarim/model/waktu_sholat/waktu_sholat_model.dart';
import 'package:dualarim/repository/remote_config_repo/remote_config_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'remote_config_event.dart';
part 'remote_config_state.dart';

class RemoteConfigBloc extends Bloc<RemoteConfigEvent, RemoteConfigState> {
  final RemoteConfigRepo remoteConfigRepo;
  WaktuSholatModel waktuSholatModel;

  RemoteConfigBloc({@required this.remoteConfigRepo})
      : assert(remoteConfigRepo != null);

  @override
  RemoteConfigState get initialState => RemoteConfigStateEmpty();

  @override
  Stream<RemoteConfigState> mapEventToState(
    RemoteConfigEvent event,
  ) async* {
    if (event is FetchWaktuSholat) {
      yield RemoteConfigStateLoading();
      try {
        waktuSholatModel = await remoteConfigRepo.getWaktuSholat(event.value);
        yield RemoteConfigStateLoaded(waktuSholatModel: waktuSholatModel);
      } catch (_) {
        yield RemoteConfigStateError();
      }
    }
  }
}
