abstract class DataSource<Type> {

  Future<List<Type>> getTypes();
  Future<void> addType(Type type);
  Future<void> removeType(Type type);
  Future<void> updateType(Type type);

}