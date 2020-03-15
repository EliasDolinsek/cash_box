abstract class Config {

  Future<DataStorageLocation> get dataStorageLocation;

}

enum DataStorageLocation { LOCAL_MOBILE, REMOTE_FIREBASE }