import 'package:get_storage/get_storage.dart';

class MLocalStorage {
  final GetStorage _storage;
  String? _uid; // Current user's UID

  // Private constructor for singleton pattern
  MLocalStorage._internal() : _storage = GetStorage();

  // Singleton instance of MLocalStorage
  static final MLocalStorage _instance = MLocalStorage._internal();

  // Public factory method to access the singleton instance
  factory MLocalStorage.instance() {
    return _instance;
  }

  // Set the current user's UID (call this after the user logs in)
  void setUserId(String uid) {
    _uid = uid;
  }

  // Save data to local storage, prefixed with the user ID
  Future<void> saveData<T>(String key, T value) async {
    if (_uid == null) return;
    await _storage.write('${_uid!}_$key', value);
  }

  // Read data from local storage, associated with the current user
  T? readData<T>(String key) {
    if (_uid == null) return null;

    return _storage.read<T>('${_uid!}_$key');
  }

  // Remove specific data associated with the current user
  Future<void> removeData(String key) async {
    if (_uid == null) return;
    await _storage.remove('${_uid!}_$key');
  }

  // Clear all data related to the current user
  Future<void> clearUserData() async {
    if (_uid == null) return;
    final keys = _storage.getKeys();
    for (var key in keys) {
      if (key.startsWith(_uid!)) {
        await _storage
            .remove(key); // Remove data that starts with the user's UID
      }
    }
  }

  // Optional: Clear all storage (use carefully)
  Future<void> clearAll() async {
    await _storage
        .erase(); // This removes all keys, not just user-specific ones
  }
}

// class MLocalStorage {
//   final GetStorage _storage;

//   MLocalStorage._internal() : _storage = GetStorage();

//   factory MLocalStorage.instance() {
//     return MLocalStorage._internal();
//   }
//   Future<void> saveData<T>(String key, T value) async {
//     await _storage.write(key, value);
//   }

//   T? readData<T>(String key) {
//     return _storage.read<T>(key);
//   }

//   Future<void> removeData(String key) async {
//     await _storage.remove(key);
//   }

//   Future<void> clearAll() async {
//     await _storage.erase();
//   }
// }
