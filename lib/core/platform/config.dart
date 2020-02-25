abstract class Config {

  Future<DataStorageLocation> get dataStorageLocation;

}

enum DataStorageLocation { LOCAL, REMOTE_FIREBASE }