import 'package:awesome1c/src/models/user.dart';
import 'package:hive/hive.dart';

part 'item.g.dart';

@HiveType(typeId: 1, adapterName: 'ItemAdapter')
class Item extends HiveObject {
  
  @HiveField(0)
  String uid;
  
  @HiveField(1)
  DateTime created;

  @HiveField(2)
  DateTime updated;
  
  @HiveField(3)
  bool isDeleted;

  @HiveField(4)
  bool isApproved;

  @HiveField(5)
  String lang;

  @HiveField(6)
  String title;

  @HiveField(7)
  String description;

  @HiveField(8)
  User user;

  @HiveField(9)
  String url;

  @HiveField(10)
  String icon;

  @HiveField(11)
  String additional;

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

  factory Item.fromUser(User user) {
    final DateTime _dt = DateTime.now();
    return Item(
      uid: Item._genUID(user, _dt),
      created: _dt,
      updated: _dt,
      isApproved: false,
    );
  }

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

  bool get isEmpty =>
    (this.uid?.isEmpty ?? true);

  bool get isNotEmpty =>
    (this.uid?.isNotEmpty ?? false);
  
  @override
  int get hashCode => 
    this.uid.hashCode;
  @override
  operator ==(Object obj) => 
    obj is Item && obj.uid == this.uid;
}