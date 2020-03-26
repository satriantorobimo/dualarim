import 'dart:convert';

import 'package:dualarim/bloc/remote_config_bloc.dart';
import 'package:dualarim/model/waktu_sholat/waktu_sholat_model.dart';
import 'package:dualarim/provider/dark_mode_provider.dart';
import 'package:dualarim/repository/remote_config_repo/remote_config_repo.dart';
import 'package:dualarim/theme/dark_mode_styles.dart';
import 'package:dualarim/util/provinsi_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:dualarim/util/check_time.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DarkModeProvider darkModeProvider = new DarkModeProvider();
  List<WaktuSholatModel> waktuSholatModel;
  final RemoteConfigBloc remoteConfigBloc =
      RemoteConfigBloc(remoteConfigRepo: new RemoteConfigRepo());

  @override
  void initState() {
    super.initState();
    cekTempatWaktuSholat();
  }

  void cekTempatWaktuSholat() async {
    ProvinsiPreference().getProvinsi().then((value) {
      print('Value $value');
      print('Provinsi Home $value');
      if (value != null) {
        remoteConfigBloc.dispatch(FetchWaktuSholat(value: value));
      } else {
        setWaktuSholatHome('Banten');
      }
    });
  }

  void setWaktuSholatHome(String value) async {
    ProvinsiPreference().setProvinsi(value);
    cekTempatWaktuSholat();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkModeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Styles.imageData(themeChange.darkMode, context)),
        centerTitle: true,
        actions: <Widget>[
          InkWell(
            onTap: () async {
              // if (themeChange.darkMode) {
              //   themeChange.darkMode = false;
              // } else {
              //   themeChange.darkMode = true;
              // }
              throw "Test exception";
            },
            child: themeChange.darkMode
                ? Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Image.asset('assets/icons/lightbulb-dark.png',
                        width: 30))
                : Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Image.asset('assets/icons/lightbulb-light.png',
                        width: 30)),
          )
        ],
      ),
      body: BlocBuilder(
        bloc: remoteConfigBloc,
        builder: (_, RemoteConfigState state) {
          if (state is RemoteConfigStateEmpty) {
            return mainContentKosong(state.props.toString());
          } else if (state is RemoteConfigStateLoading) {
            return mainContentKosong(state.props.toString());
          } else if (state is RemoteConfigStateLoaded) {
            return mainContent(state.waktuSholatModel);
          } else if (state is RemoteConfigStateError) {
            return mainContentKosong(state.props.toString());
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget mainContent(WaktuSholatModel waktuSholatModel) {
    return waktuSholatModel.toString().isNotEmpty
        ? Center(
            child: Column(
              children: <Widget>[
                Text(waktuSholatModel.nama),
                Text(waktuSholatModel.display)
              ],
            ),
          )
        : Center(child: Text('Masih Kosong'));
  }

  Widget mainContentKosong(String value) {
    return Center(child: Text('Masih Kosong'));
  }

  Widget cardSholat() {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: listTileSholat(),
      ),
    );
  }

  Widget listTileSholat() {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          "Introduction to Driving",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(" Intermediate", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));
  }
}
