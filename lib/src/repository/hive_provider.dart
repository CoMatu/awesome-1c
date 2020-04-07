import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/item.dart';
import '../models/user.dart';

class HiveProvider {
  //final Log _log = Log();
  bool _isInit = false;
  
  //
  //Box<User> _userBox;
  //Box<Item> _itemsBox;
  /// TODO: Settings box

  /// Проверка инициализации Firebase
  Future<void> init() async {
    if (_isInit) return;
    await Hive.initFlutter();
    Hive.registerAdapter<User>(UserAdapter());
    Hive.registerAdapter<Item>(ItemAdapter());

    //_userBox = await Hive.openBox<User>('user');
    //_itemsBox = await Hive.openBox<Item>('items');
    
    _isInit = true;
  }
}