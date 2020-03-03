// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:awesome1c/src/models/user.dart';
import 'package:hive/hive.dart';

///
//part 'item.g.dart';
//@HiveType(typeId: 1, adapterName: 'ItemAdapter')
class Item extends HiveObject {
  
  ///
  @HiveField(0)
  String uid;
  
  ///
  @HiveField(1)
  DateTime created;

  ///
  @HiveField(2)
  DateTime updated;
  
  ///
  @HiveField(3)
  bool isDeleted;

  ///
  @HiveField(4)
  bool isApproved;

  ///
  @HiveField(5)
  String lang;

  ///
  @HiveField(6)
  String title;

  ///
  @HiveField(7)
  String description;

  ///
  @HiveField(8)
  User user;

  ///
  @HiveField(9)
  String url;

  ///
  @HiveField(10)
  String icon;

  ///
  @HiveField(11)
  String additional;

  ///
  Item({
    this.uid,
    this.created,
    this.updated,
    this.isDeleted,
    this.isApproved,
    this.lang,
    this.title,
    this.description,
    this.user,
    this.url,
    this.icon,
    this.additional,
  }): assert(uid is String && user is User && title is String);

  ///
  factory Item.fromUser(User user) {
    final DateTime _dt = DateTime.now();
    return Item(
      uid: Item._genUID(user, _dt),
      created: _dt,
      updated: _dt,
      isApproved: false,
    );
  }

  ///
  factory Item.fromFirebase({
    String uid,
    DateTime created,
    DateTime updated,
    bool isDeleted,
    bool isApproved,
    String lang,
    String title,
    String description,
    User user,
    String url,
    String icon,
    String additional,
  }) => Item(
    uid: uid,
    created: created ?? DateTime.now(),
    updated: updated ?? DateTime.now(),
    isDeleted: isDeleted ?? false,
    isApproved: isApproved ?? false,
    lang: lang ?? 'ru',
    title: title,
    description: description,
    user: user,
    url: url,
    icon: icon,
    additional: additional,
  );

  ///
  Map<String, dynamic> toFirebase() => <String, dynamic>{
    'uid': uid,
    'created': created?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
    'updated': updated?.millisecondsSinceEpoch ?? DateTime.now().millisecondsSinceEpoch,
    'isDeleted': isDeleted ?? false,
    'isApproved': isApproved ?? false,
    'lang': lang ?? 'ru',
    'title': title,
    'description': description,
    'user': user,
    'url': url,
    'icon': icon,
    'additional': additional,
  };

  static String _genUID(User user, [DateTime date]) =>
    '${user.providerId}-${user.uid}-${(date ?? DateTime.now()).millisecondsSinceEpoch.toRadixString(36)}';

  ///
  bool get isEmpty =>
    (uid?.isEmpty ?? true);

  ///
  bool get isNotEmpty =>
    (uid?.isNotEmpty ?? false);
  
  ///
  @override
  int get hashCode => 
    uid.hashCode;

  ///
  @override
  bool operator ==(Object obj) => 
    obj is Item && obj.uid == uid;
}


// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************
class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 1;

  @override
  Item read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      uid: fields[0] as String,
      created: fields[1] as DateTime,
      updated: fields[2] as DateTime,
      isDeleted: fields[3] as bool,
      isApproved: fields[4] as bool,
      lang: fields[5] as String,
      title: fields[6] as String,
      description: fields[7] as String,
      user: fields[8] as User,
      url: fields[9] as String,
      icon: fields[10] as String,
      additional: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.updated)
      ..writeByte(3)
      ..write(obj.isDeleted)
      ..writeByte(4)
      ..write(obj.isApproved)
      ..writeByte(5)
      ..write(obj.lang)
      ..writeByte(6)
      ..write(obj.title)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.user)
      ..writeByte(9)
      ..write(obj.url)
      ..writeByte(10)
      ..write(obj.icon)
      ..writeByte(11)
      ..write(obj.additional);
  }
}