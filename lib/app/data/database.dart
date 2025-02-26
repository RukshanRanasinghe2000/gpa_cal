class DatabaseConnection {
  static final DatabaseConnection _instance = DatabaseConnection._internal();
  DatabaseConnection._internal();
  factory DatabaseConnection() => _instance;

  void openConnection() {
    print('Database connection opened');
  }


  void closeConnection() {
    print('Database connection closed');
  }
}