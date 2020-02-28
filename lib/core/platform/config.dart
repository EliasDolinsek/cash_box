abstract class Config {

  Future<DataStorageLocation> get dataStorageLocation;

}

enum DataStorageLocation { LOCAL_MOBILE, REMOTE_MOBILE_FIREBASE, REMOTE_WEB_FIREBASE }