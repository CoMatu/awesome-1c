
import 'package:awesome1c/src/models/item.dart';
import 'package:awesome1c/src/models/user.dart';
import 'package:awesome1c/src/repository/logger.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveProvider {
  final Log _log = Log();
  bool _isInit = false;
  
  //
  //Box<User> _userBox;
  Box<Item> _itemsBox;
  // Settings box

  /// Проверка инициализации Firebase
  Future<void> init() async {
    if (this._isInit) return;
    await Hive.initFlutter();
    Hive.registerAdapter<User>(UserAdapter());
    Hive.registerAdapter<Item>(ItemAdapter());

    //_userBox = await Hive.openBox<User>('user');
    _itemsBox = await Hive.openBox<Item>('items');
    
    this._isInit = true;
  }
}