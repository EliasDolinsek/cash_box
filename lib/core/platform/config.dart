import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io' show Platform;

abstract class Config {

  Future<DataStorageLocation> get dataStorageLocation;

  void setDataStorageLocation(DataStorageLocation location);

}

enum DataStorageLocation { LOCAL_MOBILE, REMOTE_FIREBASE }

class ConfigDefaultImpl implements Config {

  static const dataStorageLocationKey = "dataStorageLocation";

  final SharedPreferences sharedPreferences;

  ConfigDefaultImpl(this.sharedPreferences);

  @override
  Future<DataStorageLocation> get dataStorageLocation async {
    if(!kIsWeb && (Platform.isAndroid || Platform.isIOS)){
      final locationAsString = sharedPreferences.getString(dataStorageLocationKey);
      if(locationAsString == null || locationAsString.isEmpty) return DataStorageLocation.LOCAL_MOBILE;
      return dataStorageLocationFromString(locationAsString);
    } else {
      return DataStorageLocation.REMOTE_FIREBASE;
    }
  }

  DataStorageLocation dataStorageLocationFromString(String location){
    if(location == DataStorageLocation.LOCAL_MOBILE.toString()){
      return DataStorageLocation.LOCAL_MOBILE;
    } else if(location == DataStorageLocation.REMOTE_FIREBASE.toString()){
      return DataStorageLocation.REMOTE_FIREBASE;
    } else {
      throw new Exception("Couldn't resolve DataStorageLocation from String $location");
    }
  }

  @override
  void setDataStorageLocation(DataStorageLocation location) async {
    await sharedPreferences.setString(dataStorageLocationKey, location.toString());
  }
}