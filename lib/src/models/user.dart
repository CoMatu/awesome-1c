// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:hive/hive.dart';

///
//part 'user.g.dart';
//@HiveType(typeId: 0, adapterName: 'UserAdapter')
class User extends HiveObject {
  
  /// The provider identifier.
  @HiveField(0)
  String providerId;

  /// The provider’s user ID for the user.
  @HiveField(1)
  String uid;

  /// The name of the user.
  @HiveField(2)
  String displayName;

  /// The user’s email address.
  @HiveField(3)
  String email;

  /// The URL of the user’s profile photo.
  @HiveField(4)
  String photoUrl;

  ///
  bool get isEmpty =>
    (providerId?.isEmpty ?? true)
    && (uid?.isEmpty ?? true);

  ///
  bool get isNotEmpty =>
    (providerId?.isNotEmpty ?? false)
    && (uid?.isNotEmpty ?? false);

  ///
  User({
    String providerId,
    String uid,
    String displayName,
    String email,
    String photoUrl,
  }) : assert(providerId is String && uid is String && displayName is String && email is String)
    , providerId = providerId ?? ''
    , uid = uid ?? ''
    , displayName = displayName ?? ''
    , email = email ?? ''
    , photoUrl = photoUrl ?? '';

  ///
  User.empty()
    : providerId = ''
    , uid = ''
    , displayName = ''
    , email = ''
    , photoUrl = '';

  ///
  factory User.fromFirebase({
    String providerId,
    String uid,
    String displayName,
    String email,
    String photoUrl,
  }) => User(
    providerId: providerId,
    uid: uid,
    displayName: displayName,
    email: email,
    photoUrl: photoUrl,
  );

  ///
  Map<String, dynamic> toFirebase() => <String, dynamic>{
    'providerId': providerId,
    'uid': uid,
    'displayName': displayName,
    'email': email,
    'photoUrl': photoUrl,
  };

  ///
  bool hasImage() =>
    isNotEmpty && (photoUrl?.isNotEmpty ?? false);

  ///
  @override
  int get hashCode => 
    '$providerId-$uid'.hashCode;

  ///
  @override
  bool operator ==(Object obj) => 
    obj is User 
    && obj.providerId == providerId 
    && obj.uid == uid;

  ///
  @override
  String toString() =>
    isEmpty
    ? 'Неавторизованный пользователь'
    : '$displayName ($email)';
}


// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************
class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User()
      ..providerId = fields[0] as String
      ..uid = fields[1] as String
      ..displayName = fields[2] as String
      ..email = fields[3] as String
      ..photoUrl = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.providerId)
      ..writeByte(1)
      ..write(obj.uid)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.photoUrl);
  }
}